require 'twitter'
require './infra/tweetrepository.rb'

TweetRepository.new.get_tweets("java")
