require './infra/texttweetdb.rb'
require './domain/model/SearchWords.rb'
class GetService

  def initialize(text_tweet_repository)
    @text_tweet_repository = text_tweet_repository
  end

  def get_hot_tweet(search_words)
    @text_tweet_repository.get_hot_tweet(search_words)
  end
end
