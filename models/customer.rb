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
    results_hash = results[0]
    customer = Customer.new(results_hash)
    return customer
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    result = customers.map {|customer| Customer.new(customer)}
    return result
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