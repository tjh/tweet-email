class TweetDigests < ActionMailer::Base
  default :from => "sara@theharveys.org"

  def single(subscription, tweets)
    @tweets       = tweets
    @subscription = subscription
    mail :to => subscription.email,
         :subject => "Recent tweets from #{subscription.screen_name}"
  end
end
