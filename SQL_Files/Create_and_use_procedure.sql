  CREATE OR ALTER PROCEDURE dbo.AddOrderLineItem
 	@SalesOrderID INT,
 	@ProductID    INT,
 	@Quantity     INT
 AS
 BEGIN
 	SET NOCOUNT ON;
 	BEGIN TRANSACTION;
    
 	DECLARE @UnitPrice DECIMAL(18,2);
 	SELECT @UnitPrice = CAST(ListPrice AS DECIMAL(18,2))
 	FROM SalesLT.Product
 	WHERE ProductID = @ProductID;
    
 	IF @UnitPrice IS NULL
 	BEGIN
 		ROLLBACK TRANSACTION;
 		THROW 50010, 'Invalid ProductID specified.', 1;
 	END
    
 	-- Ensure SalesOrderID exists
 	IF NOT EXISTS (SELECT 1 FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
 	BEGIN
 		ROLLBACK TRANSACTION;
 		THROW 50011, 'Invalid SalesOrderID specified.', 1;
 	END
    
 	-- Insert line item (no discount)
 	INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount)
 	VALUES (@SalesOrderID, @Quantity, @ProductID, @UnitPrice, 0);
    
 	-- Update header subtotal based on current line totals
 	UPDATE h
 	SET SubTotal = d.SumLineTotal,
 		ModifiedDate = SYSUTCDATETIME()
 	FROM SalesLT.SalesOrderHeader h
 	INNER JOIN (
 		SELECT SalesOrderID, SUM(LineTotal) AS SumLineTotal
 		FROM SalesLT.SalesOrderDetail
 		WHERE SalesOrderID = @SalesOrderID
 		GROUP BY SalesOrderID
 	) d ON d.SalesOrderID = h.SalesOrderID;
    
 	COMMIT TRANSACTION;
 END;

 -- Add a line item to an existing order (choose a valid SalesOrderID)
 DECLARE @SalesOrderID INT = (SELECT TOP 1 SalesOrderID 
                             FROM SalesLT.SalesOrderHeader 
                             ORDER BY SalesOrderID DESC);
 EXEC dbo.AddOrderLineItem @SalesOrderID = @SalesOrderID,         
                             @ProductID = 680, 
                             @Quantity = 1; -- adjust ProductID as needed
    
 SELECT TOP (5) * 
 FROM SalesLT.SalesOrderDetail 
 WHERE SalesOrderID = @SalesOrderID 
 ORDER BY SalesOrderDetailID DESC;

 SELECT SalesOrderID, SubTotal, TaxAmt, Freight, TotalDue 
 FROM SalesLT.SalesOrderHeader 
 WHERE SalesOrderID = @SalesOrderID;