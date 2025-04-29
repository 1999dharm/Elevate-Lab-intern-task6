Create DATABASE BOOK_STORE;
USE BOOK_STORE;

SELECT * FROM BOOKS;

SELECT * FROM CUSTOMERS;

SELECT * FROM ORDERS;





--- -- 1) Retrieve all book in the "Fiction",genre 

SELECT * FROM books
WHERE genre = "Fiction";


-- 2) Find the published after the year 1950;
SELECT * FROM books
WHERE Published_year = "1950";

-- 3) List all customers from the Canada-- 
SELECT * FROM customers
WHERE country = "CANADA";

-- 4) show orders placed in November 2023

SELECT * FROM ORDERS
WHERE order_date between "2023-11-01" and "2023-11-30";


-- 5)Retrieve the total stock of books availabel:
SELECT SUM(STOCK) AS stock FROM BOOKS;


-- 6) Find the details of most expensive book;
SELECT * FROM BOOKS
ORDER BY PRICE DESC LIMIT 1;


-- 7) Show all customer who ordered more than 1 quantity of a book:
SELECT * FROM ORDERS
WHERE quantity > 1;


-- 8) Retrieve all orders  where the total amount exceeds $20
SELECT * FROM ORDERS
WHERE total_amount>20;


-- 9) List all genre availabel in the books table:
SELECT distinct genre FROM BOOKS;


-- 10) Find the book with the lowest stock:
SELECT stock FROM books
ORDER BY stock ASC LIMIT 1;


-- 11) calculate the total revenue generated from all orders;
SELECT * FROM ORDERS;
SELECT * FROM BOOKS;

SELECT round(SUM(total_amount),1) AS revenue
FROM orders;


-- 12) Retrieve the total number of books sold for each genre:
SELECT b.genre,sum(o.quantity)  As total_book_stold
FROM orders o INNER JOIN books b
ON b.book_id = o.order_id
GROUP BY B.genre;



-- 13) Find the average price of book in the "Fantasy" genre;

SELECT AVG(price) as average_price_book
FROM BOOKS
WHERE genre = "Fantasy";


-- 14) Lis the customers who have placed at least 2 orders;

SELECT 
    O.CUSTOMER_ID, C.NAME, COUNT(O.ORDER_ID) AS ORDER_COUNT
FROM
    ORDERS O
        JOIN
    CUSTOMERS C ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY O.CUSTOMER_ID , C.NAME
HAVING COUNT(ORDER_ID);



-- 15) Find  the most frequently ordered book:
SELECT O.book_id,b.title,count(O.order_id) as order_count
FROM ORDERS O
JOIN BOOKS b
ON O.ORDER_ID = b.book_id
GROUP BY o.book_id,b.title
ORDER BY order_count DESC LIMIT 1;


-- 16) Show the top 3 most expensive books of "fantasy" genre:
SELECT * FROM BOOKS
WHERE genre = 'fantasy'
ORDER BY price DESC LIMIT 3;


-- 17) Retrieve the Total quantity of book sold by each author:
SELECT b.author,sum(o.quantity) as total_book_sold
FROM BOOKS B JOIN ORDERS O
ON b.book_id = o.order_id
GROUP BY b.author;


-- 18) List the cities where customer who spent
-- over $30 are located:

SELECT distinct c.city,o.total_amount
FROM ORDERS O JOIN CUSTOMERS C
ON o.order_id = c.customer_id
WHERE o.total_amount > 30;


-- 19) Find the customer who spent the most on orders:
select * from customers;
select * from orders;

SELECT c.customer_id,c.name,sum(o.total_amount) as total_spent
FROM CUSTOMERs C JOIN ORDERS O
ON c.customer_id = o.customer_id
GROUP BY C.customer_id , c.name
ORDER BY total_spent desc LIMIT 1;


-- 20) Calculate the stock remaining after fulfilling all orders:
SELECT 
  b.book_id,
  b.title,
  b.stock,
  COALESCE(SUM(o.quantity), 0) AS order_quantity,
	b.stock - COALESCE(SUM(o.quantity), 0) as remaining_quantity
FROM 
  books b
LEFT JOIN 
  orders o
ON 
  b.book_id = o.book_id
GROUP BY 
  b.book_id, b.title, b.stock;

