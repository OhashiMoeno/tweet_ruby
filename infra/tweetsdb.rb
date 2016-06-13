require 'twitter'
require './infra/texttweetdb.rb'
require './domain/model/tweet.rb'
require './domain/model/searchwords.rb'
require './domain/model/texttweet.rb'
require './domain/model/valueobject.rb'

class TweetsDB < TweetRepository
  def get_tweets(search_words)
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ""
        config.consumer_secret     = ""
        config.access_token        = ""
        config.access_token_secret = ""

      since_id = nil

      # count : 取得する件数
      # result_type : 内容指定。recentで最近の内容、popularで人気の内容。
      # exclude : 除外する内容。retweetsでリツイートを除外。
      # since_id : 指定ID以降から検索だが、検索結果が100件以上の場合は無効。
      result_tweets = client.search(search_words.value, count: 100, result_type: "recent", exclude:"links", lang: "ja")

      puts 'tweetゲットスタート'
      tweet_list = []
      result_tweets.take(100).each_with_index do |tw|
        if tw.retweet? then
          tw = tw.retweeted_tweet
          #(tw.retweeted_tweet.id, tw.retweeted_tweet.full_text, tw.retweeted_tweet.retweet_count, searchword, tw.retweeted_tweet.created_at.strftime("%Y-%m-%d %H:%M:%S"), tw.retweeted_tweet.url.to_s)
          #tweetlist(tw.id, tw.full_text, tw.retweet_count, searchword, tw.created_at.strftime("%Y-%m-%d %H:%M:%S"), tw.url.to_s)
        end
        tweet_list.push(TextTweet.new(
          TweetId.new(tw.id),
          Text.new(tw.full_text),
          RetweetCount.new(tw.retweet_count),
          TweetTime.new(tw.created_at.strftime("%Y-%m-%d %H:%M:%S")),
          TweetUrl.new(tw.url.to_s),search_words))
      end

      tweet_list
    end
end
