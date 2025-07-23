USE [management];
GO

-- 1. Populate Customer table with 100 rows
DECLARE @i INT = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO [dbo].[Customer] (Name, Address, Email, PhoneNumber)
    VALUES (
        'Customer ' + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3),
        'Address '  + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3),
        'customer'  + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3) + '@example.com',
        '555-010-'  + RIGHT('000' + CAST(@i AS VARCHAR(3)), 3)
    );
    SET @i += 1;
END
GO

-- 2. Populate Product table with 100 rows
DECLARE @j INT = 1;
WHILE @j <= 100
BEGIN
    INSERT INTO [dbo].[Product] (Name, Description, Price, Category)
    VALUES (
        'Product ' + RIGHT('000' + CAST(@j AS VARCHAR(3)), 3),
        'Description for product ' + RIGHT('000' + CAST(@j AS VARCHAR(3)), 3),
        CAST(ROUND((RAND(CHECKSUM(NEWID())) * 990 + 10), 2) AS DECIMAL(18,2)),
        CASE @j % 5
            WHEN 0 THEN 'Category A'
            WHEN 1 THEN 'Category B'
            WHEN 2 THEN 'Category C'
            WHEN 3 THEN 'Category D'
            ELSE        'Category E'
        END
    );
    SET @j += 1;
END
GO

-- 3. Populate Inventory table with 100 rows
DECLARE @k INT = 1;
WHILE @k <= 100
BEGIN
    INSERT INTO [dbo].[Inventory] (ProductID, Quantity, Location)
    VALUES (
        @k,
        ABS(CHECKSUM(NEWID())) % 500 + 1,
        'Location ' + RIGHT('000' + CAST(@k AS VARCHAR(3)), 3)
    );
    SET @k += 1;
END
GO

-- 4. Populate Order table with 100 rows
DECLARE @l INT = 1;
WHILE @l <= 100
BEGIN
    DECLARE @custID INT = (SELECT TOP 1 CustomerID FROM [dbo].[Customer] ORDER BY NEWID());
    DECLARE @prodID INT = (SELECT TOP 1 ProductID  FROM [dbo].[Product]  ORDER BY NEWID());
    DECLARE @qty    INT = ABS(CHECKSUM(NEWID())) % 10 + 1;
    DECLARE @price  DECIMAL(18,2) = (SELECT Price FROM [dbo].[Product] WHERE ProductID = @prodID);
    DECLARE @total  DECIMAL(18,2) = @price * @qty;
    INSERT INTO [dbo].[Order] (CustomerID, ProductID, Quantity, OrderDate, TotalAmount)
    VALUES (
        @custID,
        @prodID,
        @qty,
        DATEADD(DAY, - (ABS(CHECKSUM(NEWID())) % 365), GETDATE()),
        @total
    );
    SET @l += 1;
END
GO
