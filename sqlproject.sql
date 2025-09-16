CREATE DATABASE BOOKDETAILS;


SELECT  * FROM books;     -- shows all the record from books table

SELECT * FROM orders;     -- shows all the records from orders table

SELECT * FROM customers;    -- shows all the records from customers table


-- Retrive all books in the "fiction" genre

SELECT * FROM books
WHERE Genre="Fiction";

-- Find books published after the year 1950

SELECT * FROM books
WHERE  Published_Year > 1950;          -- filter all the  data which is  published after 1950

-- List all customers from the  canada

SELECT * FROM customers
WHERE Country ="canada";

-- Show orders placed in november 2023

SELECT * FROM orders
WHERE Order_Date BETWEEN "2023-11-01" AND "2023-11-30";

-- Retrieve  the total stock of books available

SELECT SUM(stock) AS total_stock FROM books; 

-- Find the details of the most expensive book

SELECT * FROM BOOKS
ORDER BY Price DESC
LIMIT 1;

-- Show all customers who order more than one quantity of a book

SELECT * FROM Orders
WHERE quantity >1;

-- Retrieve all orders where total amount exceeds $20

SELECT * FROM orders
WHERE Total_Amount>20;

-- List all genres available in the books table

SELECT DISTINCT genre FROM books;

-- Find the book with lowest stock

SELECT * FROM books 
ORDER BY stock 
LIMIT 1;

-- Calculate the total revenue generated from all orders
SELECT SUM(Total_Amount) AS Total_Revenue  FROM  orders;

-- Retrieve the total number of books sold for each genre

SELECT b.genre, SUM(o.quantity) AS Total_Books_Sold
 FROM orders o
 JOIN Books b ON o.book_id=b.book_id
 GROUP BY b.genre;
  
  -- Find the average price of books in the "Fantasy" genre
  
  SELECT AVG(price) AS average_price From books
  WHERE Genre ="Fantasy";
  
  -- List customers who have placed at least 2 orders
  
SELECT Customer_ID,COUNT(Order_id) AS Order_Count
FROM orders
GROUP BY customer_id
HAVING Order_count>=2;
  
  
SELECT o.Customer_ID, c.name,COUNT(o.Order_id) AS Order_Count
FROM orders o
JOIN  customers c ON o.customer_id=c.customer_id 
GROUP BY o.customer_id,c.name
HAVING Order_count>=2;  
 
-- Find the most frequently ordered book
SELECT Book_ID,COUNT(Order_id) AS Order_Count FROM orders
GROUP BY Book_ID
ORDER BY Order_Count DESC
LIMIT 1;
-- Show top 3 most expensive  books of "Fantasy" genre

SELECT * FROM books
WHERE Genre ="Fantasy"
ORDER BY price DESC
LIMIT 3;

-- Retrieve the total quantity of books sold by  each author
SELECT b.Author,SUM(o.quantity) AS Total_Books_Sold
FROM ORDERS o
JOIN BOOKS b ON o.book_id=b.book_id
GROUP BY b.Author;

-- List the cities where customers who spent over $30 are located

SELECT DISTINCT c.city
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount>30;

-- Find the customer who spent tje most on orders

SELECT c.customer_id,c.name ,SUM(o.Total_Amount) AS Total_Spend
FROM  orders o
JOIN  customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.name
ORDER BY Total_Spend DESC
LIMIT 1;

-- Calculate the stock remaining after fulfilling all orders


SELECT b.book_id,b.title,b.stock,
COALESCE(SUM(o.quantity), 0) AS Order_Quantity,
b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id,b.title, b.stock;



