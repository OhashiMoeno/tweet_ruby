require './domain/model/valueobject.rb'

class TextTweet
  attr_reader :tweet_id, :text, :retweet_count, :tweet_time, :tweet_url, :search_words

  def initialize(tweet_id, text, retweet_count, tweet_time, tweet_url,search_words)
    @tweet_id = tweet_id
    @text = text
    @retweet_count = retweet_count
    @tweet_time = tweet_time
    @tweet_url = tweet_url
    @search_words = search_words
  end
end

class TweetId < ValueObject
end

class Text < ValueObject
end

class RetweetCount < ValueObject
end

class TweetTime < ValueObject
end

class TweetUrl < ValueObject
end

class TextTweetRepository
  def overwriting(tweet_list)
  end
  def get_hot_tweet(search_words)
  end
end
