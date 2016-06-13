require './infra/searchworddb.rb'
require './domain/model/searchwords.rb'

class SearchService
  def initialize(search_words_repository)
    @search_words_repository = search_words_repository
  end

  def put_search_words(search_words)
    @search_words_repository.put_words(search_words)
  end
end

#SearchService.new.put_search_words("bar")
