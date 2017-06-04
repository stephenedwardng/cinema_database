require('pg')
require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :time
  attr_accessor :film_id
  attr_accessor :ticket_id

  def initialize(options)
    @id = options['id'].to_i
    @time = options['time']
    @film_id = options['film_id'].to_i
    @ticket_id = options['ticket_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (time, film_id, ticket_id) VALUES ('#{@time}', '#{@film_id}', '#{@ticket_id}') RETURNING *;"
    screening = SqlRunner.run(sql)
    @id = screening[0]['id'].to_i
  end

  def find()
    sql = "SELECT * FROM screenings WHERE id = #{@id};"
    results = SqlRunner.run(sql)
    return results.map { |results_hash| Screening.new(results_hash)}
  end

  def self.all()
    sql = "SELECT * FROM screenings;"
    results = SqlRunner.run(sql)
    return results.map {|screening| Screening.new(screening)}
  end

  def update()
    sql = "UPDATE screenings SET (time, film_id, ticket_id) = ('#{@time}', '#{@film_id}', '#{@ticket_id}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end