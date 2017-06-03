DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY UNIQUE,
  name VARCHAR(255),
  funds INT2 UNIQUE
);

CREATE TABLE films (
  id SERIAL8 PRIMARY KEY UNIQUE,
  title VARCHAR(255),
  price INT2 UNIQUE
);

CREATE TABLE tickets (
  id SERIAL8 PRIMARY KEY,
  customer_id INT8 REFERENCES customers(id) ON DELETE CASCADE,
  customer_funds INT2 REFERENCES customers(funds) ON DELETE CASCADE,
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE,
  film_price INT8 REFERENCES films(price) ON DELETE CASCADE
);