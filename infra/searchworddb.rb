# require ../model/SearchWords.rb
require 'sqlite3'
require './infra/tweetdb.rb'

class SearchWordsDB
  def create_db(searchword)

    sql = <<-SQL
    create table if not exists Word(
    word TEXT
    );
    SQL
    db = SQLite3::Database.new 'searchword.db'
    db.execute(sql)

    #トランザクションによる値の挿入
    db.transaction do
      sql = "insert into Word values (?)"
      count = db.execute("select count(*) from Word where word = ?",searchword)[0][0]
      if count == 0 then
        db.execute("insert into Word values (?)", searchword)
      end
    end

    db.execute('select * from Word') do |row|
      puts row.join("\t")
    end
    db.close
    tweet = TweetDB.new
    tweet.get_tweets(searchword)
 end
end
