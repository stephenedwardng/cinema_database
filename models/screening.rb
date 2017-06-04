require('pg')
require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :film_id
  attr_accessor :ticket_id
  attr_accessor :time

  def initialize(options)
    @id = options['id'].to_i
    @time = options['time']
    @film_id = options['film_id'].to_i
    @ticket_id = options['ticket_id'].to_i
  end

end