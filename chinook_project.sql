
/* Q : Let’s find all customers from Brazil and check how much they spent on music. */

SELECT c.CustomerId, c.FirstName, c.LastName, c.Country,
       SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i
ON i.CustomerId = c.CustomerId
where i.BillingCountry = "Brazil"
GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Country
ORDER BY c.Country, TotalSpent desc 

/* Q: What are the total sales for 2010 and 2011? How many invoices have been generated for those years? */

SELECT Year(i.InvoiceDate) AS Year, Sum(Total) AS Total_Sales
FROM Invoice i
WHERE Year(i.InvoiceDate) LIKE '2010'
OR Year(i.InvoiceDate) LIKE '2011'
GROUP BY Year;

/* Q: Check which sales agent made the most in sales in 2011? */

SELECT e.Employeeid, concat(e.Firstname," ", e.Lastname) "name of Employee", SUM(i.Total) AS Total_sales FROM Employee e
INNER JOIN Customer c ON c.SupportRepId = e.EmployeeId 
INNER JOIN Invoice i ON i.CustomerId = c.CustomerId
WHERE i.InvoiceDate LIKE "%2011%"
GROUP BY e.EmployeeId 
LIMIT 1

/* Q: List 5 customers who spent the most money */

SELECT c.CustomerId, c.FirstName, c.LastName, c.Country,
       SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i
ON i.CustomerId = c.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Country
ORDER BY  TotalSpent desc 
LIMIT 5


/* Q: Check how many customers is listening Blues or Jazz music. */


SELECT 
    g.name as Genre, COUNT(DISTINCT c.CustomerId) CountCustomers
FROM
    customer c
         JOIN invoice i ON c.customerid = i.customerid
         JOIN invoiceline il ON i.invoiceid = il.invoiceid
         JOIN track t ON il.trackid = t.trackid
         JOIN genre g ON t.genreId = g.genreId
GROUP BY Genre
HAVING g.name IN ("Jazz", "Blues")


/* Q: Let's find the artists who have written the most Jazz music in the dataset. 
Write a query that returns the Artist name and total track count of the top 5 Jazz bands. */


SELECT a.name 'Artist Name', COUNT(t.trackid) FROM artist a
INNER JOIN album al 
ON a.ArtistId = al.ArtistId 
INNER JOIN track t
ON t.AlbumId = al.AlbumId 
INNER JOIN genre g
ON g.GenreId = t.GenreId 
WHERE g.Name LIKE "%jazz%"
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 5;