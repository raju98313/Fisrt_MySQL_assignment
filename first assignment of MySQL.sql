# fisrt assingments of MySQL


use sakila;
select * from actor;

#Q1. Create a table called employees with the following structure
-- emp_id (integer, should not be NULL and should be a primary key)
-- emp_name (text, should not be NULL)
-- age (integer, should have a check constraint to ensure the age is at least 18)
-- email (text, should be unique for each employee)
-- salary (decimal, with a default value of 30,000).
-- Write the SQL query to create the above table with all constraints

drop table employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY NOT NULL,
    emp_name varchar(10) NOT NULL,
    age INT CHECK (age >= 18),
    email varchar(23)  UNIQUE,
    salary DECIMAL DEFAULT 30000
);


#Q 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
-- examples of common types of constraints.
-- Constraints enforce rules at the column or table level to ensure valid, consistent, and reliable data.
-- They prevent invalid entries and maintain relationships between tables.

-- Common types of constraints:
-- PRIMARY KEY: Uniquely identifies each row (e.g., emp_id)
-- NOT NULL: Ensures a column cannot have NULL values (e.g., emp_name)
-- UNIQUE: Prevents duplicate values in a column (e.g., email)
-- CHECK: Validates data based on a condition (e.g., age >= 18)
-- DEFAULT: Assigns a default value if none is provided (e.g., salary = 30000)
-- FOREIGN KEY: Links rows in one table to another (not used in this example)


 #Q3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
 
 -- NOT NULL ensures that a column must always have a value.
-- It's used when a field is essential for the record (e.g., emp_name must be present).

-- A PRIMARY KEY cannot contain NULL values because:
-- It must uniquely identify each row.
-- NULL represents unknown or missing data, which violates uniqueness.
-- Therefore, every primary key must be NOT NULL by definition.


 #Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint
 
 -- 🔹 Add a CHECK constraint to ensure salary is at least 25000
ALTER TABLE employees
ADD CONSTRAINT chk_salary_min CHECK (salary >= 25000);

-- 🔹 Remove the CHECK constraint named chk_salary_min
ALTER TABLE employees
DROP CONSTRAINT chk_salary_min;


 #Q5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint
 
 -- If you try to insert or update data that breaks a constraint, the database will reject the operation.

-- Example: Trying to insert an employee with age < 18
INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (101, 'John Doe', 16, 'john@example.com');

-- ❌ Error message:
-- ERROR: new row for relation "employees" violates check constraint "employees_age_check"
-- DETAIL: Failing row contains (101, John Doe, 16, john@example.com, 30000).


#Q6. You created a products table without constraints as follows:

 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));
 
 -- Add PRIMARY KEY constraint to product_id
ALTER TABLE products
ADD PRIMARY KEY (product_id);

-- Modify price column to set default value as 50.00
ALTER TABLE products
MODIFY COLUMN price DECIMAL(10, 2) DEFAULT 50.00;



 #Q7. You have two tables.Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
 #Answer
 
 # create the student table 
create table students (
  student_id int primary key,
  student_name varchar(50),
  class_id int
);

insert into students (student_id, student_name, class_id)
values
(1, 'ankur', 101),
(2, 'mohit', 102),
(3, 'sunny', 103);

# create the classes table
create table classes (
  class_id int primary key,
  class_name varchar(50)
);

insert into classes (class_id, class_name)
values
(101, 'math'),
(102, 'Scince'),
(103, 'History');
#Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

select * from students;
select * from classes;

SELECT 
    s.student_name, 
    c.class_name 
FROM 
    students AS s
INNER JOIN 
    classes AS c
ON 
    s.class_id = c.class_id;
    
# LEFT joint
SELECT 
    s.student_name, 
    c.class_name 
FROM 
    students AS s
left JOIN 
    classes AS c
ON 
    s.class_id = c.class_id;
    
    
#Q8. Consider the following three tables

create table orders (
 order_id int primary key,
 order_date date,
 customer_id int,
 foreign key (customer_id) references
customers(customer_id)
);

-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

-- Insert data into Customers
INSERT INTO Customers (customer_id, customer_name)
VALUES
(101, 'Alice'),
(102, 'Bob');


-- Create the Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert data into Orders
INSERT INTO Orders (order_id, order_date, customer_id)
VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);


-- Create the Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    order_id INT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert data into Products
INSERT INTO Products (product_id, product_name, order_id)
VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);


-- Final Query (Question 8)
SELECT 
    p.product_name,
    o.order_id,
    c.customer_name
FROM 
    Products p
LEFT JOIN 
    Orders o ON p.order_id = o.order_id
LEFT JOIN 
    Customers c ON o.customer_id = c.customer_id;
    
    
    
#Q9 Given the following tables Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

create table products (
product_id int primary key,
product_name varchar(100) not null
);

create table sales (
sale_id int primary key,
product_id int,
Quentity int,
price_Per_unit decimal(10,2),
foreign key (product_id) references products (product_id)
);

-- Sample products
INSERT INTO Products (product_id, product_name) VALUES
(101, 'Laptop'),
(102, 'phone');


-- Sample sales
INSERT INTO Sales (sale_id, product_id, quantity, price_per_unit) VALUES
(1, 101, 2, 500.00),
(2, 102, 5, 300.00),
(3, 101, 1, 700.00);
 
 
 SELECT 
    p.product_name,
    SUM(s.quantity * s.price_per_unit) AS total_sales_amount
FROM 
    Products p
INNER JOIN 
    Sales s ON p.product_id = s.product_id
GROUP BY 
    p.product_name;
    
    
#Q10. You are given three tables:
 -- Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
-- customer using an INNER JOIN between all three tables.
 -- Note - The above-mentioned questions don't require any dataset.

drop table customers, orders, order_details;
  
create table customers (
  customer_id int primary key,
  customer_name varchar(50)
);


create table Orders (
order_id int primary key,
order_date date,
customer_id int,
foreign key (customer_id) references customers(customer_id)
);


create table Order_details (
 order_id int, 
 product_id int,
 quantity int,
 foreign key (order_id) references orders(order_id)
 );
 
 
insert into customers ( customer_id,
customer_name)
values
(1, 'Alice'),
(2,'Bob');

insert into orders (order_id, order_date,
customer_id)
values
(101, '2024-01-02', 1),
(102, '2024-01-05', 2);

insert into order_details (order_id,
product_id, Quantity)
values
(101, 1, 2),
(102, 2, 3);

SELECT 
    o.order_id,
    c.customer_name,
    od.quantity
FROM 
    Orders o
INNER JOIN 
    Customers c ON o.customer_id = c.customer_id
INNER JOIN 
    Order_Details od ON o.order_id = od.order_id;
    
    

# SQL COMMANDS

use sakila;

show tables;

 #Q1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
 
 -- Primary Key: Uniquely identifies each record in a table
-- Foreign Key: Links a record in one table to a record in another table

-- Example:
-- actor_id in 'actor' table is a PRIMARY KEY
-- actor_id in 'film_actor' table is a FOREIGN KEY referencing 'actor'


#Q2- List all details of actors
select first_name, last_name from actor;

#Q 3 -List all customer information from DB.
select * from customer;

#Q 4 -List different countries
select distinct country from country;

#Q 5 -Display all active customers.
select * from customer
where active = 1;

-- Q6: List of all rental IDs for customer with ID 1
SELECT rental_id 
FROM rental 
WHERE customer_id = 1;

 -- Q7 - Display all the films whose rental duration is greater than 5 .
select  *
from film
where rental_duration > 5;


-- Q8: Total number of films with replacement cost > $15 and < $20
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

-- Q9: Count of unique first names of actors
SELECT COUNT(DISTINCT first_name) AS unique_actor_names
FROM actor;

-- Q10: First 10 records from the customer table
SELECT * 
FROM customer
LIMIT 10;

-- Q11: First 3 customers whose first name starts with ‘b’
SELECT * 
FROM customer
WHERE first_name LIKE 'B%'
LIMIT 3;

-- Q12: First 5 movies rated as ‘G’
SELECT title 
FROM film
WHERE rating = 'G'
LIMIT 5;

-- Q13: Customers whose first name starts with "a"
SELECT * 
FROM customer
WHERE first_name LIKE 'A%';

-- Q14: Customers whose first name ends with "a"
SELECT * 
FROM customer
WHERE first_name LIKE '%a';

-- Q15: First 4 cities that start and end with ‘a’
SELECT city 
FROM city
WHERE city LIKE 'A%a'
LIMIT 4;

-- Q16: Customers whose first name contains "NI"
SELECT * 
FROM customer
WHERE first_name LIKE '%NI%';

-- Q17: Customers whose first name has "r" in the second position
SELECT * 
FROM customer
WHERE first_name LIKE '_r%';

-- Q18: Customers whose first name starts with "a" and is at least 5 characters long
SELECT * 
FROM customer
WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

-- Q19: Customers whose first name starts with "a" and ends with "o"
SELECT * 
FROM customer
WHERE first_name LIKE 'A%o';

-- Q20: Films with PG and PG-13 rating using IN operator
SELECT * 
FROM film
WHERE rating IN ('PG', 'PG-13');

-- Q21: Films with length between 50 and 100 using BETWEEN
SELECT * 
FROM film
WHERE length BETWEEN 50 AND 100;

-- Q22: Top 50 actors using LIMIT
SELECT * 
FROM actor
LIMIT 50;

-- Q23: Distinct film IDs from inventory table
SELECT DISTINCT film_id 
FROM inventory;


#Functions
 #Basic Aggregate Functions
 
 -- Question 1:
-- Retrieve the total number of rentals made in the Sakila database.
SELECT COUNT(*) AS total_rentals
FROM rental;
-- output 16044 

-- Question 2:
-- Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT AVG(rental_duration) AS average_duration
FROM film;
-- output 4.9850

-- Question 3:
-- Display the first name and last name of customers in uppercase.
SELECT 
    UPPER(first_name) AS first_name_upper,
    UPPER(last_name) AS last_name_upper
FROM customer;
-- Output firt_name_upper, last_name_upper

-- Question 4:
-- Extract the month from the rental date and display it alongside the rental ID.
SELECT 
    rental_id,
    MONTH(rental_date) AS rental_month
FROM rental;

-- Question 5:
-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT 
    customer_id,
    COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

-- Question 6:
-- Find the total revenue generated by each store.
SELECT 
    store_id,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

-- Question 7:
-- Determine the total number of rentals for each category of movies.
SELECT 
    c.name AS category_name,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Question 8:
-- Find the average rental rate of movies in each language.
SELECT 
    l.name AS language_name,
    AVG(f.rental_rate) AS average_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;
-- Output English 2.980000


#Joins

-- Question 9:
-- Display the title of the movie, customer's first name, and last name who rented it.
-- Hint: Use JOIN between the film, inventory, rental, and customer tables.
SELECT 
    f.title AS movie_title,
    c.first_name,
    c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

-- Question 10:
-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
-- Hint: Use JOIN between the film_actor, film, and actor tables.
SELECT 
    a.first_name,
    a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

-- Question 11:
-- Retrieve the customer names along with the total amount they've spent on rentals.
-- Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

-- Question 12:
-- List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
SELECT 
    c.first_name,
    c.last_name,
    f.title AS movie_title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ct.city = 'London'
GROUP BY c.customer_id, f.title;



## Advanced Joins and GROUP BY

-- Question 13:
-- Display the top 5 rented movies along with the number of times they've been rented.
-- Hint: JOIN film, inventory, and rental tables, then use COUNT() and GROUP BY, and limit the results.
SELECT 
    f.title AS movie_title,
    COUNT(r.rental_id) AS times_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY times_rented DESC
LIMIT 5;

-- Question 14:
-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;


##Windows Function

-- Question 1:
-- Rank the customers based on the total amount they've spent on rentals.
SELECT 
    customer_id,
    first_name,
    last_name,
    SUM(amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS spending_rank
FROM customer
JOIN payment USING (customer_id)
GROUP BY customer_id;

-- Question 2:
-- Calculate the cumulative revenue generated by each film over time.
SELECT 
    f.title,
    r.rental_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM payment p
JOIN rental r USING (rental_id)
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id);

-- Question 3:
-- Determine the average rental duration for each film, considering films with similar lengths.
SELECT 
    length,
    AVG(rental_duration) AS avg_duration
FROM film
GROUP BY length;

-- Question 4:
-- Identify the top 3 films in each category based on their rental counts.
SELECT 
    category_name,
    title,
    rental_count
FROM (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
    FROM rental r
    JOIN inventory i USING (inventory_id)
    JOIN film f USING (film_id)
    JOIN film_category fc USING (film_id)
    JOIN category c USING (category_id)
    GROUP BY c.name, f.title
) ranked
WHERE rank_in_category <= 3;

-- Question 5:
-- Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
SELECT 
    customer_id,
    first_name,
    last_name,
    COUNT(rental_id) AS total_rentals,
    COUNT(rental_id) - (
        SELECT AVG(rental_count) FROM (
            SELECT COUNT(*) AS rental_count
            FROM rental
            GROUP BY customer_id
        ) AS avg_table
    ) AS rental_difference
FROM customer
JOIN rental USING (customer_id)
GROUP BY customer_id;

-- Question 6:
-- Find the monthly revenue trend for the entire rental store over time.
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS monthly_revenue
FROM payment
GROUP BY month
ORDER BY month;

-- Question 7:
-- Identify the customers whose total spending on rentals falls within the top 20% of all customers.
SELECT 
    customer_id,
    first_name,
    last_name,
    total_spent
FROM (
    SELECT 
        customer_id,
        first_name,
        last_name,
        SUM(amount) AS total_spent,
        NTILE(5) OVER (ORDER BY SUM(amount) DESC) AS spending_quintile
    FROM customer
    JOIN payment USING (customer_id)
    GROUP BY customer_id
) ranked
WHERE spending_quintile = 1;

-- Question 8:
-- Calculate the running total of rentals per category, ordered by rental count.
SELECT 
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM (
    SELECT 
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i USING (inventory_id)
    JOIN film f USING (film_id)
    JOIN film_category fc USING (film_id)
    JOIN category c USING (category_id)
    GROUP BY c.name
) AS category_rentals;

-- Question 9:
-- Find the films that have been rented less than the average rental count for their respective categories.
SELECT 
    c.name AS category_name,
    f.title,
    COUNT(r.rental_id) AS film_rentals
FROM rental r
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
JOIN film_category fc USING (film_id)
JOIN category c USING (category_id)
GROUP BY c.name, f.title
HAVING film_rentals < (
    SELECT AVG(rental_count) FROM (
        SELECT 
            c2.name AS category_name,
            COUNT(r2.rental_id) AS rental_count
        FROM rental r2
        JOIN inventory i2 USING (inventory_id)
        JOIN film f2 USING (film_id)
        JOIN film_category fc2 USING (film_id)
        JOIN category c2 USING (category_id)
        WHERE c2.name = c.name
        GROUP BY f2.title
    ) AS avg_table
);

-- Question 10:
-- Identify the top 5 months with the highest revenue and display the revenue generated in each month.
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS monthly_revenue
FROM payment
GROUP BY month
ORDER BY monthly_revenue DESC
LIMIT 5;


##Normalisation & CTE

-- 1. First Normal Form (1NF)
-- Assume a hypothetical table 'customer_contact' with multiple phone numbers in one column
-- Normalize by creating a separate table for phone numbers

-- Original (violates 1NF)
-- customer_id | phone_numbers
-- ------------|----------------
-- 1           | '123-456,789-012'

-- Normalized
CREATE TABLE customer_phone (
    customer_id INT,
    phone_number VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- 2. Second Normal Form (2NF)
-- Assume 'rental_summary' with partial dependency on composite key (rental_id, film_id)
-- Normalize by separating film details

-- Original
-- rental_id | film_id | film_title | rental_date

-- Normalized
CREATE TABLE film_details (
    film_id INT PRIMARY KEY,
    film_title VARCHAR(255)
);

CREATE TABLE rental_summary (
    rental_id INT,
    film_id INT,
    rental_date DATETIME,
    FOREIGN KEY (film_id) REFERENCES film_details(film_id)
);

-- 3. Third Normal Form (3NF)
-- Assume 'staff_info' with transitive dependency: staff_id → store_id → store_address

-- Original
-- staff_id | store_id | store_address

-- Normalized
CREATE TABLE store (
    store_id INT PRIMARY KEY,
    store_address VARCHAR(255)
);

CREATE TABLE staff_info (
    staff_id INT PRIMARY KEY,
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

-- 4. Normalization Process: Unnormalized to 2NF
-- Unnormalized table: 'film_rental' with repeated groups
-- film_id | title | actor_1 | actor_2 | rental_rate

-- 1NF: Remove repeating groups
CREATE TABLE film_actor_map (
    film_id INT,
    actor_id INT,
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);

-- 2NF: Remove partial dependencies
-- Assume composite key (film_id, actor_id) → title, rental_rate
-- Move title and rental_rate to film table

-- Already handled in Sakila schema

-- 5. CTE Basics: Actor film count
WITH ActorFilmCount AS (
    SELECT a.actor_id, a.first_name || ' ' || a.last_name AS actor_name,
           COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, actor_name
)
SELECT * FROM ActorFilmCount;

-- 6. CTE with Joins: Film title, language, rental rate
WITH FilmLanguage AS (
    SELECT f.title, l.name AS language, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM FilmLanguage;

-- 7. CTE for Aggregation: Total revenue per customer
WITH CustomerRevenue AS (
    SELECT customer_id, SUM(amount) AS total_revenue
    FROM payment
    GROUP BY customer_id
)
SELECT cr.customer_id, c.first_name, c.last_name, cr.total_revenue
FROM CustomerRevenue cr
JOIN customer c ON cr.customer_id = c.customer_id;

-- 8. CTE with Window Functions: Rank films by rental duration
WITH FilmRank AS (
    SELECT film_id, title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT * FROM FilmRank;

-- 9. CTE and Filtering: Customers with more than 2 rentals
WITH FrequentRenters AS (
    SELECT customer_id, COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 2
)
SELECT fr.customer_id, c.first_name, c.last_name, fr.rental_count
FROM FrequentRenters fr
JOIN customer c ON fr.customer_id = c.customer_id;

-- 10. CTE for Date Calculations: Rentals per month
WITH MonthlyRentals AS (
    SELECT DATE_TRUNC('month', rental_date) AS rental_month,
           COUNT(*) AS total_rentals
    FROM rental
    GROUP BY rental_month
)
SELECT * FROM MonthlyRentals;

-- 11. CTE and Self-Join: Actor pairs in same film
WITH ActorPairs AS (
    SELECT fa1.film_id, fa1.actor_id AS actor1, fa2.actor_id AS actor2
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT ap.film_id, a1.first_name || ' ' || a1.last_name AS actor1_name,
       a2.first_name || ' ' || a2.last_name AS actor2_name
FROM ActorPairs ap
JOIN actor a1 ON ap.actor1 = a1.actor_id
JOIN actor a2 ON ap.actor2 = a2.actor_id;

-- 12. CTE for Recursive Search: Staff reporting hierarchy
WITH RECURSIVE StaffHierarchy AS (
    SELECT staff_id, first_name || ' ' || last_name AS staff_name, reports_to
    FROM staff
    WHERE reports_to = 1  -- Replace with manager_id

    UNION ALL

    SELECT s.staff_id, s.first_name || ' ' || s.last_name, s.reports_to
    FROM staff s
    JOIN StaffHierarchy sh ON s.reports_to = sh.staff_id
)
SELECT * FROM StaffHierarchy;