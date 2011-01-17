desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  USERNAME = 'saralharvey'

  # Get all the tweets
  Twitter.user_timeline(USERNAME).each do |t|
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

  # Email any unsent tweets
  TweetDigests.single(USERNAME).deliver

  # Mark all as sent
  Tweet.update_all :is_sent => true, :username => USERNAME
end