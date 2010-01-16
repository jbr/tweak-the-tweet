class AddHashToRawTweets < ActiveRecord::Migration
  def self.up
    add_column :raw_tweets, :text_hash, :integer, :limit => 8
    add_index :raw_tweets, :text_hash, :unique => true
  end

  def self.down
    remove_column :raw_tweets, :text_hash
  end
end
