class TweetDigests < ActionMailer::Base
  default :from => "sara@theharveys.org"

  def single(screen_name)
    @screen_name = screen_name
    @tweets = Tweet.unsent
    mail :to => "tim@theharveys.org",
         :subject => "Recent tweets from 'saralharvey'"
  end
end
