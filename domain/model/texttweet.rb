require './domain/model/valueobject.rb'

class TextTweet
  attr_reader :id, :text, :retweet, :search_words, :tweet_time
  def initialize(id, text, retweet, search_words, tweet_time)
    @id = id
    @text = text
    @search_words = search_words
    @tweet_time = tweet_time
  end
end

class TweetId < ValueObject
end

class Text < ValueObject
end

class Retweet < ValueObject
end

class TweetTime < ValueObject
end

class TextTweetRepository
  # input
  #   - search_words: SerchWords
  #
  # return List<TextTweet>
  def get_hot_tweet(search_words)
  end
end
