class CreateRawTweets < ActiveRecord::Migration
  def self.up
    create_table :raw_tweets do |t|
      t.text :text
      t.string :from_user
      t.integer :to_user_id
      t.integer :tweet_id, :limit => 8
      t.string :geo
      t.integer :from_user_id
      t.string :iso_language_code
      t.string :source
      t.string :profile_image_url
      t.datetime :tweet_time
      t.boolean :is_parsed, :default => false
      t.boolean :is_retweeted, :default => false

      t.timestamps
    end
    add_index :raw_tweets, :tweet_id
  end

  def self.down
    drop_table :raw_tweets
  end
end
