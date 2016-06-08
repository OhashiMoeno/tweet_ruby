require 'sqlite3'
require './domain/model/texttweet.rb'
require './domain/model/SearchWords.rb'

class TextTweetDB < TextTweetRepository

  def overwriting(id,text,retweet,searchword,tweettime,url)
    sql = <<-SQL
    create table if not exists TextTweet(
    id TEXT,
    tweeet_text TEXT,
    retweet integer,
    searchword TEXT,
    tweettime CURRENT_TIMESTAMP,
    url TEXT,
    updatetime_utc date
    );
    SQL
    db = SQLite3::Database.new 'texttweet.db'
    db.execute(sql)

    #トランザクションによる値の挿入
    db.transaction do
      count = db.execute("select count(*) from TextTweet where id = ?",id)[0][0]
      if count == 0 then
        sql = "insert into TextTweet values (?,?,?,?,?,?,current_timestamp)"
        db.execute(sql, id, text, retweet, searchword, tweettime, url)
      else
        db.execute("UPDATE TextTweet SET retweet = ? where id = ?",retweet,id)
      end
    end
    db.close
    str = "ok!"
  end

  # input
  #   - search_words: SerchWords
  #
  # return List<TextTweet>
  def get_hot_tweet(search_words)
    result = []
    sql = "SELECT * FROM TextTweet WHERE searchword = ? and retweet > 0 ORDER BY retweet DESC"
    db =SQLite3::Database.new 'texttweet.db'
      db.execute(sql, search_words.value) do |row|
        result.push(TextTweet.new(
          TweetId.new(row[0]),
          Text.new(row[1]),
          Retweet.new(row[2]),
          SearchWords.new(row[3]),
          TweetTime.new(row[4])
        ))
      end
      db.close
      result
  end
end
