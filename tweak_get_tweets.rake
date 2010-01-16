namespace :tweak do
  desc 'Find Tweaked Tweets'
  task :get_tweets => :environment do
    require 'pp'
    max_since_id = 0
    t = Twitter::Search.new()

    while true
      # only find tweets that have #haiti and one of the lexicon keywords, and
      # use the since from the last run - must restore it here because it needs
      # to be set for each query
      new_max_id = max_since_id
      Lexicon::PRIMARY_TAGS.each do |tag|
        t.clear
        t.per_page(500)
        t.since(new_max_id)
        t.containing("#haiti")
        t.containing("#{tag}")
        t.each do |r|

        # OK, now we do the real processing. For now, the tweet must start with
        # #haiti - otherwise we ignore it - this helps prevent the RT dupes, as
        # well as other tweets that may accidentally have some of the same tags
        # over time we will need to get smarter than this, but for now...
  
          if r.text.downcase[/^\#haiti/] && r.from_user != "tweaked_haiti"
            pp r
            raw_tweet = RawTweet.find_or_initialize_by_text_hash(r[:text].hash)
            if raw_tweet.new_record?
              raw_tweet.save_all_data(r)
            end
          end
  
          # grab the highest tweet, so we aren't constantly pulling old tweets
          max_since_id = r[:id] if r[:id] > max_since_id
         
        end
      end

      puts "Sleeping - At the beep, the time will be #{Time.now} and max_since_id = #{max_since_id}"
      sleep 120

    end
  end
end
