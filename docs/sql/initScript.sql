CREATE TABLE "Company" (
  "id" integer PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "email" varchar(100) UNIQUE NOT NULL,
  "address_id" integer,
  "created_at" timestamp
);

CREATE TABLE "Inventory" (
  "id" integer PRIMARY KEY,
  "id_company" integer,
  "location" varchar(100),
  "created_at" timestamp
);

CREATE TABLE "Department" (
  "id" integer PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "description" text,
  "id_company" integer
);

CREATE TABLE "Product" (
  "id" integer PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "description" text,
  "price" decimal(10,2) NOT NULL,
  "ean" varchar(13) UNIQUE,
  "id_department" integer
);

CREATE TABLE "InventoryProduct" (
  "id" integer PRIMARY KEY,
  "id_product" integer,
  "id_inventory" integer,
  "serial_number" varchar(50),
  "state" varchar(50)
);

CREATE TABLE "Client" (
  "id" integer PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "email" varchar(100) UNIQUE NOT NULL,
  "address_id" integer,
  "date_registered" date
);

CREATE TABLE "Bill" (
  "id" integer PRIMARY KEY,
  "id_client" integer,
  "created_at" timestamp,
  "total_amount" decimal(10,2) NOT NULL,
  "payment_status" varchar(20) NOT NULL,
  "payment_method" varchar(50),
  "paid_at" timestamp
);

CREATE TABLE "BillProduct" (
  "id" integer PRIMARY KEY,
  "id_bill" integer,
  "id_inventory_product" integer,
  "quantity" integer NOT NULL,
  "price" decimal(10,2) NOT NULL,
  "discount" decimal(10,2) DEFAULT 0
);

CREATE TABLE "Address" (
  "id" integer PRIMARY KEY,
  "street" varchar(100) NOT NULL,
  "city" varchar(50) NOT NULL,
  "state" varchar(50) NOT NULL,
  "postal_code" varchar(20),
  "country" varchar(50) NOT NULL
);

ALTER TABLE "Inventory" ADD FOREIGN KEY ("id_company") REFERENCES "Company" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Department" ADD FOREIGN KEY ("id_company") REFERENCES "Company" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Product" ADD FOREIGN KEY ("id_department") REFERENCES "Department" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "InventoryProduct" ADD FOREIGN KEY ("id_product") REFERENCES "Product" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "InventoryProduct" ADD FOREIGN KEY ("id_inventory") REFERENCES "Inventory" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Bill" ADD FOREIGN KEY ("id_client") REFERENCES "Client" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "BillProduct" ADD FOREIGN KEY ("id_bill") REFERENCES "Bill" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "BillProduct" ADD FOREIGN KEY ("id_inventory_product") REFERENCES "InventoryProduct" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Address" ADD FOREIGN KEY ("id") REFERENCES "Client" ("address_id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Address" ADD FOREIGN KEY ("id") REFERENCES "Company" ("address_id") ON DELETE CASCADE ON UPDATE CASCADE;
