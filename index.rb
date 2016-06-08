require 'sinatra'
require 'json'
require './domain/model/valueobject.rb'
require './infra/searchworddb.rb'
require './domain/model/searchwords.rb'
require './domain/service/getservice.rb'



class Word < ValueObject

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
