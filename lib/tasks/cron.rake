desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  # Loop through each unique screen name with a subscription
  Subscription.by_screen_name.collect { |s| s.screen_name }.uniq.each do |screen_name|
    # Get all the tweets
    Twitter.user_timeline(screen_name).each do |t|
      next if !t.in_reply_to_screen_name.blank?

      logged_tweet = Tweet.find_or_initialize_by_tweet_id(t.id)
      if logged_tweet.new_record?
        logged_tweet.message            = t.text
        logged_tweet.user_id            = t.user.id
        logged_tweet.username           = t.user.screen_name
        logged_tweet.message_created_at = t.created_at
        logged_tweet.is_sent            = false
        logged_tweet.save!
      end
    end

    # Get a list of unsent tweets for this screen name
    tweets = Tweet.where(:username => screen_name).unsent
    if tweets.size > 0
      # Email them to each subscriber
      Subscription.where(:screen_name => screen_name).each do |subscription|
        TweetDigests.single(subscription, tweets).deliver
      end
      # Mark tweets all as sent
      Tweet.update_all :is_sent => true, :username => screen_name
    end
  end
end