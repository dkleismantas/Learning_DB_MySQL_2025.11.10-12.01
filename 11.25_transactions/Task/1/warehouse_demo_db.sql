
DROP DATABASE IF EXISTS warehouse_demo;
CREATE DATABASE warehouse_demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE warehouse_demo;


CREATE TABLE customers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(80) NOT NULL,
  email VARCHAR(120) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  sku VARCHAR(40) NOT NULL UNIQUE,
  name VARCHAR(120) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE warehouses (
  id INT PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(20) NOT NULL UNIQUE,
  title VARCHAR(120) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE stock (
  product_id INT NOT NULL,
  warehouse_id INT NOT NULL,
  qty INT NOT NULL,
  PRIMARY KEY (product_id, warehouse_id),
  CONSTRAINT fk_stock_product FOREIGN KEY (product_id) REFERENCES products(id),
  CONSTRAINT fk_stock_warehouse FOREIGN KEY (warehouse_id) REFERENCES warehouses(id)
) ENGINE=InnoDB;

CREATE TABLE orders (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(id)
) ENGINE=InnoDB;

CREATE TABLE order_items (
  order_id BIGINT NOT NULL,
  product_id INT NOT NULL,
  qty INT NOT NULL,
  PRIMARY KEY (order_id, product_id),
  CONSTRAINT fk_items_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;


INSERT INTO customers(name,email) VALUES
('Alice','alice@example.com'),('Bob','bob@example.com');

INSERT INTO products(sku,name) VALUES
('SKU-USB','USB-C Cable'),('SKU-LAPTOP','Laptop 14"');

INSERT INTO warehouses(code,title) VALUES
('W1','Central Warehouse'),('W2','City Depot');


INSERT INTO stock(product_id, warehouse_id, qty) VALUES
(1,1,50),(1,2,50),  -- USB-C
(2,1,10),(2,2,10);  -- Laptop
