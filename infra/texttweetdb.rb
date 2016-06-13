require 'sqlite3'
require './domain/model/texttweet.rb'
require './domain/model/searchwords.rb'


class TextTweetDB < TextTweetRepository

  def overwriting(tweet_list)
    sql = <<-SQL
    create table if not exists TextTweet(
    id TEXT,
    tweeet_text TEXT,
    retweet_count integer,
    tweet_time CURRENT_TIMESTAMP,
    url TEXT,
    updatetime_utc date,
    searchwords TEXT
    );
    SQL
    db = SQLite3::Database.new 'texttweet.db'
    db.execute(sql)

    #トランザクションによる値の挿入


    db.transaction do
      tweet_list.each{|tweet|

        count = db.execute("select count(*) from TextTweet where id = ?",tweet.tweet_id.value)[0][0]
        if count == 0 then
          sql = "insert into TextTweet values (?,?,?,?,?,current_timestamp,?)"
          db.execute(sql, tweet.tweet_id.value, tweet.text.value, tweet.retweet_count.value, tweet.tweet_time.value, tweet.tweet_url.value, tweet.search_words.value)
        else
          db.execute("UPDATE TextTweet SET retweet_count = ? where id = ?",tweet.retweet_count.value,tweet.tweet_id.value)
        end
      }
    end
    db.close

  end

  # input
  #   - search_words: SerchWords
  #
  # return List<TextTweet>
  def get_hot_tweet(search_words)
    result = []
    sql = "SELECT * FROM TextTweet WHERE searchwords = ? and retweet_count > 0 ORDER BY retweet_count DESC"
    db =SQLite3::Database.new 'texttweet.db'
      db.execute(sql, search_words.value) do |row|
        result.push(TextTweet.new(
          TweetId.new(row[0]),
          Text.new(row[1]),
          RetweetCount.new(row[2]),
          SearchWords.new(row[3]),
          TweetTime.new(row[4]),
          TweetUrl.new(row[5])
        ))
      end
      db.close
      result
  end
end
