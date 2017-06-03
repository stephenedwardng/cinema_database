require('pg')
require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title
  attr_accessor :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', '#{@price}') RETURNING *;"
    film = SqlRunner.run(sql)
    @id = film[0]['id'].to_i
  end

  def find()
    sql = "SELECT * FROM films WHERE id = #{@id};"
    results = SqlRunner.run(sql)
    return results.map { |results_hash| Film.new(results_hash)}
  end

  def self.all()
    sql = "SELECT * FROM films;"
    films = SqlRunner.run(sql)
    return films.map {|film| Film.new(film)}
  end

  def update()
    sql = "UPDATE films SET (title, price) = ('#{@title}', '#{@price}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers_booked()
    # sql = "SELECT * FROM tickets WHERE customer_id = #{@id};"
    sql = "SELECT films.title AS film, customers.name AS customer FROM tickets 
    INNER JOIN customers
    ON customers.id = tickets.customer_id
    INNER JOIN films
    ON films.id = tickets.film_id
    WHERE film_id = #{@id};"
    results = SqlRunner.run(sql)
    return results.map { |results_hash| Ticket.new(results_hash)}
  end

  def count_customers_booked()
    return customers_booked.count()
  end


end