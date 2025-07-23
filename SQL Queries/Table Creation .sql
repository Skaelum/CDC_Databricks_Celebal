USE [management];
GO

-- make sure Customer and Product tables exist first
CREATE TABLE [dbo].[Customer] (
    CustomerID   INT            IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name         NVARCHAR(100)  NOT NULL,
    Address      NVARCHAR(255)  NULL,
    Email        NVARCHAR(255)  NOT NULL UNIQUE,
    PhoneNumber  NVARCHAR(20)   NULL
);
GO

CREATE TABLE [dbo].[Product] (
    ProductID   INT             IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name        NVARCHAR(100)   NOT NULL,
    Description NVARCHAR(255)   NULL,
    Price       DECIMAL(18,2)   NOT NULL,
    Category    NVARCHAR(100)   NULL
);
GO

-- create the Order table, using proper brackets and explicit FOREIGN KEY clauses
CREATE TABLE [dbo].[Order] (
    OrderID      INT             IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CustomerID   INT             NOT NULL,
    ProductID    INT             NOT NULL,
    Quantity     INT             NOT NULL,
    OrderDate    DATETIME        NOT NULL DEFAULT GETDATE(),
    TotalAmount  DECIMAL(18,2)   NOT NULL,
    CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerID)
        REFERENCES [dbo].[Customer](CustomerID),
    CONSTRAINT FK_Order_Product  FOREIGN KEY (ProductID)
        REFERENCES [dbo].[Product](ProductID)
);
GO

-- finally, the Inventory table
CREATE TABLE [dbo].[Inventory] (
    InventoryID  INT             IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ProductID    INT             NOT NULL,
    Quantity     INT             NOT NULL,
    Location     NVARCHAR(100)   NULL,
    CONSTRAINT FK_Inventory_Product FOREIGN KEY (ProductID)
        REFERENCES [dbo].[Product](ProductID)
);
GO
