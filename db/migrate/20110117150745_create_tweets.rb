class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer :tweet_id, :limit => 8
      t.integer :user_id, :limit => 8
      t.string :username
      t.text :message
      t.datetime :message_created_at
      t.boolean :is_sent, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
