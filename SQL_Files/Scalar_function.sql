CREATE OR ALTER FUNCTION dbo.fnOrderTotal (@OrderID INT)
     RETURNS DECIMAL(18,2)
     AS
     BEGIN
     	DECLARE @Total DECIMAL(18,2);

     	SELECT @Total = SUM(LineTotal)
     	FROM SalesLT.SalesOrderDetail
     	WHERE SalesOrderID = @OrderID;

     	RETURN ISNULL(@Total, 0.00);
     END;

SELECT d.SalesOrderID, dbo.fnOrderTotal(d.SalesOrderID) AS OrderTotal
 FROM SalesLT.SalesOrderDetail d
 GROUP BY d.SalesOrderID
 ORDER BY d.SalesOrderID DESC;