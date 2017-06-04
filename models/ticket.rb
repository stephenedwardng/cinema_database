require('pg')
require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id
  attr_accessor :customer_funds
  attr_accessor :film_id
  attr_accessor :film_price

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @customer_funds = options['customer_funds'].to_i
    @film_id = options['film_id'].to_i
    @film_price = options['film_price'].to_i
  end

  def save()
      sql = "INSERT INTO tickets (customer_id, film_id) VALUES ('#{@customer_id}', '#{@film_id}') RETURNING *;"
      ticket = SqlRunner.run(sql)
      @id = ticket[0]['id'].to_i
      decrease_customer_funds()
  end

  def find()
    sql = "SELECT * FROM tickets WHERE id = #{@id};"
    results = SqlRunner.run(sql)
    return results.map { |results_hash| Ticket.new(results_hash)}
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    tickets = SqlRunner.run(sql)
    return tickets.map {|ticket| Ticket.new(ticket)}
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ('#{@customer_id}', '#{@film_id}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def decrease_customer_funds()
    @customer_funds -= @film_price
    sql = "UPDATE customers SET (funds) = ('#{@customer_funds}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

end