class Tweet < ActiveRecord::Base
  scope :unsent, where(:is_sent => false)
end
