require 'sinatra'
require 'json'
require './domain/model/valueobject.rb'
require './infra/searchworddb.rb'
require './infra/tweetsdb.rb'
require './domain/model/searchwords.rb'
require './domain/service/getservice.rb'
require './domain/service/searchservice.rb'
require './domain/service/collectservice.rb'

get '/add/word' do
  search_words = SearchWords.new(params['word'])
  SearchService.new(SearchWordsDB.new).put_search_words(search_words)
  CollectService.new(TweetsDB.new,TextTweetDB.new).set_search_word(search_words)

  return "ok"
end




get '/get/hottweet' do
  search_words = SearchWords.new(params['word'])
  getservice = GetService.new(TextTweetDB.new)
  tweet_list = getservice.get_hot_tweet(search_words)
  map_list = tweet_list.map {|row| { tweet_id: row.tweet_id.value, text: row.text.value } }
  p map_list
  JSON.generate(map_list)
end


 get '/add/result' do
   strSearchWord = params['word']
   p params['word']
   searchword = SearchWords.new(strSearchWord)
   getservice = GetService.new
   getservice.check_search_words(searchword)
  #  JSON.generate({
  #
  #    })
 end
