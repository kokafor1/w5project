CREATE TABLE Salesperson (
    salesperson_id serial PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Customer (
    customer_id serial PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);


CREATE TABLE Car (
    car_id serial PRIMARY KEY,
    serial_number VARCHAR(20) UNIQUE,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT
);


CREATE TABLE Invoice (
    invoice_id serial PRIMARY KEY,
    car_id INT,
    salesperson_id INT,
    FOREIGN KEY (car_id) REFERENCES Car(car_id),
    FOREIGN KEY (salesperson_id) REFERENCES Salesperson(salesperson_id)
);

CREATE TABLE Service_Ticket (
    ticket_id serial PRIMARY KEY,
    car_id INT,
    customer_id INT,
    FOREIGN KEY (car_id) REFERENCES Car(car_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Service_Record (
    record_id serial PRIMARY KEY,
    car_id INT,
    FOREIGN KEY (car_id) REFERENCES Car(car_id)
);

CREATE TABLE Mechanic (
    mechanic_id serial PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Service_Ticket_Mechanic (
    ticket_id INT,
    mechanic_id INT,
    PRIMARY KEY (ticket_id, mechanic_id),
    FOREIGN KEY (ticket_id) REFERENCES Service_Ticket(ticket_id),
    FOREIGN KEY (mechanic_id) REFERENCES Mechanic(mechanic_id)
);


INSERT INTO Salesperson (salesperson_id, name)
VALUES (1, 'John Doe'),
       (2, 'Jane Smith');

INSERT INTO Customer (customer_id, name, age, email, phone_number)
VALUES (1, 'Alice Johnson', 35, 'alice@example.com', '123-456-7890'),
       (2, 'Bob Smith', 45, 'bob@example.com', '987-654-3210');

INSERT INTO Car (car_id, serial_number, make, model, year)
VALUES (1, '123ABC', 'Toyota', 'Camry', 2020),
       (2, '456DEF', 'Honda', 'Accord', 2019);


INSERT INTO Invoice (invoice_id, car_id, salesperson_id)
VALUES (1, 1, 1),
       (2, 2, 2);

INSERT INTO Service_Ticket (ticket_id, car_id, customer_id)
VALUES (1, 1, 1),
       (2, 2, 2);

INSERT INTO Service_Record (record_id, car_id)
VALUES (1, 1),
       (2, 2);

INSERT INTO Mechanic (mechanic_id, name)
VALUES (1, 'Mike Johnson'),
       (2, 'Emily Brown');

INSERT INTO Service_Ticket_Mechanic (ticket_id, mechanic_id)
VALUES (1, 1),
       (1, 2),
       (2, 1);
      
select *
from service_record sr ;

create or replace procedure add_car(
	p_car_id int,
	p_serial_number varchar(20),
	p_make varchar(50),
	p_model varchar(50),
	p_year int
)
language plpgsql
as $$
begin
	insert into Car(car_id, serial_number, make, model, year)
	values(p_car_id, p_serial_number, p_make, p_model, p_year);
end;
$$;

CALL add_car(3,'789GHI', 'Ford', 'Fusion', 2018);


create or replace procedure add_customer (
	p_customer_id int,
	p_name varchar(50),
	p_age int,
	p_email varchar(100),
	p_phone_number varchar(20)
)
language plpgsql
as $$
begin 
	insert into Customer (customer_id, name, age, email, phone_number)
    values (p_customer_id, p_name, p_age, p_email, p_phone_number);
end;
$$;

CALL add_customer(3,'John Doe', 30, 'john@example.com', '123-456-7890');

select *
from customer;