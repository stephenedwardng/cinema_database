require('pg')

class SqlRunner

  def self.run()
    begin
      db = PG.connect({
        dbname: 'cinema',
        host: 'localhost'
        })
      result = db.exec(sql)
    ensure
      db.close()
    end
    return result
  end

end