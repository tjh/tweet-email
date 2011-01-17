class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string :screen_name
      t.string :email
      t.integer :approval_code

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
