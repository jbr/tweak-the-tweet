class RawTweet < ActiveRecord::Base
  def save_all_data(src_tweet)
    self.text              = src_tweet[:text]
    self.from_user         = src_tweet[:from_user]
    self.to_user_id        = src_tweet[:to_user_id]
    self.tweet_id          = src_tweet[:id]
    self.geo               = src_tweet[:geo]
    self.from_user_id      = src_tweet[:from_user_id]
    self.iso_language_code = src_tweet[:iso_language_code]
    self.source            = src_tweet[:source]
    self.profile_image_url = src_tweet[:profile_image_url]
    self.tweet_time        = src_tweet[:created_at]
    self.save
  end
end
