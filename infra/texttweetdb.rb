require 'sqlite3'
#require './domain/model/texttweet.rb'

class TextTweetDB

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

  def get_hot_tweet(searchword)
    str = ""
    sql = "SELECT * FROM TextTweet WHERE searchword = ? and retweet > 0 ORDER BY retweet DESC"
    db =SQLite3::Database.new 'texttweet.db'
      db.execute(sql, searchword.value) do |row|
        str += row.join
      end
      db.close
      str
  end
end
