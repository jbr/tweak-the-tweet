namespace :tweak do
  desc 'Retweet the tweaked tweets'
  task :retweet => :environment do
    require 'pp'

    httpauth = Twitter::HTTPAuth.new('haititweaks', 'katecam30')

    t = Twitter::Base.new(httpauth)

    while true
      rts = RawTweet.find_all_by_is_retweeted(false)
      rts.each do |rt|
        pp t.update(rt.text.gsub("&amp;","&"), :in_reply_to_status_id => rt.tweet_id)
        rt.is_retweeted = true
        rt.save
      end

      puts "Sleeping - At the beep, the time will be #{Time.now}"
      sleep 120
    end
  end
end
