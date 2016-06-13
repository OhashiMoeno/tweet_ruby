require './infra/texttweetdb.rb'
require './domain/model/searchwords.rb'
require './domain/model/tweet.rb'

class CollectService
 def initialize(tweet_db_repositry,texttweet_db_repositry)
   @tweet_db_repositry = tweet_db_repositry
   @texttweet_db_repositry = texttweet_db_repositry
 end

  def set_search_word(search_words)
     tweet_list = @tweet_db_repositry.get_tweets(search_words)
     @texttweet_db_repositry.overwriting(tweet_list)

  end

end
