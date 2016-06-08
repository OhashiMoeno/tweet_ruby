require 'sinatra'
require 'json'
require './domain/model/valueobject.rb'
require './infra/searchworddb.rb'
require './domain/model/searchwords.rb'
require './domain/service/getservice.rb'

get '/get/hottweet' do
  search_words = SearchWords.new(params['word'])
  getservice = GetService.new(TextTweetDB.new)
  tweet_list = getservice.get_hot_tweet(search_words)
  map_list = tweet_list.map {|row| { id: row.id.value, text: row.text.value } }
  p map_list
  JSON.generate(map_list)
end

  get '/add/word' do
    p params
    strWord = params['word']
    word = Word.new(strWord).value
    searchworddb = SearchWordsDB.new
    searchworddb.create_db(word)
    # JSON.generate({
    #   word:word.value
    #   })
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
