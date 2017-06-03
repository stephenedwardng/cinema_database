require('pg')
require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name
  attr_accessor :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', '#{@funds}') RETURNING *;"
    customer = SqlRunner.run(sql)
    @id = customer[0]['id'].to_i
  end

  def find()
    sql = "SELECT * FROM customers WHERE id = #{@id};"
    results = SqlRunner.run(sql)
    # For reference / revision purposes
    # results_hash = results[0]
    # customer = Customer.new(results_hash)
    # return customer
    return results.map { |results_hash| Customer.new(results_hash)}
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    return customers.map {|customer| Customer.new(customer)}
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', '#{@funds}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end