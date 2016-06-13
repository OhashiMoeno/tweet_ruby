# require ../model/SearchWords.rb
require 'sqlite3'
require './infra/tweetsdb.rb'
require './domain/model/searchwords.rb'

class SearchWordsDB < SearchWordsRepository
  def put_words(search_words)


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
      count = db.execute("select count(*) from Word where word = ?",search_words.value)[0][0]
      if count == 0 then
        db.execute("insert into Word values (?)", search_words.value)
      end
    end
    db.execute('select * from Word') do |row|
      puts row.join("\t")
    end
    db.close
 end
end
