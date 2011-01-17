class Subscription < ActiveRecord::Base
  validates_presence_of :email, :if => :valid_twitter_screen_name
  validates_uniqueness_of :email, :scope => :screen_name, :message => 'has already subscribed to that screen name'

  scope :by_screen_name, order("screen_name")

  def valid_twitter_screen_name
    begin
      Twitter.user(screen_name)
      return true
    rescue Twitter::NotFound => e
      errors.add(:screen_name, 'is not a valid Twitter name. Please try a different one.')
      return false
    rescue => e
      errors.add(:screen_name, "could not be verified with Twitter (#{e.message}). Please try again.")
      return false
    end
  end
end
