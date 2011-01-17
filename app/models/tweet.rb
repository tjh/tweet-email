class Tweet < ActiveRecord::Base
  scope :unsent, where(:is_sent => false) & order("message_created_at")
end
