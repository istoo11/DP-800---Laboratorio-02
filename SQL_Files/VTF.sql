 CREATE OR ALTER FUNCTION dbo.GetCustomerOrders (@CustomerID INT)
 RETURNS TABLE
 AS
 RETURN
 (
 	SELECT 
 		h.SalesOrderID,
 		h.OrderDate
 	FROM SalesLT.SalesOrderHeader h
 	WHERE h.CustomerID = @CustomerID
 );

SELECT * 
 FROM dbo.GetCustomerOrders(29929)
 ORDER BY OrderDate DESC;
 
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, o.SalesOrderID, o.OrderDate
 FROM SalesLT.Customer c
     CROSS APPLY dbo.GetCustomerOrders(c.CustomerID) o
 WHERE c.CustomerID = 29929;