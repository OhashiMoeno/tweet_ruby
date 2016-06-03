require 'sinatra'
require 'json'
require './domain/model/valueobject.rb'
require './infra/searchworddb.rb'

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
