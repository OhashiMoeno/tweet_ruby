require './infra/texttweetdb.rb'
class GetService
  def check_search_words(searchword)
    text_tweet_db = TextTweetDB.new
    text_tweet_db.get_hot_tweet(searchword)
  end
end
