class TweetDigests < ActionMailer::Base
  default :from => "Tweet Email <tim@literacy5.com>"

  def single(subscription, tweets)
    @tweets       = tweets
    @subscription = subscription
    mail :to => subscription.email,
         :subject => "Recent tweets from #{subscription.screen_name}"
  end
end
