CREATE TABLE ProductionOrders
(
    Id INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_ProductionOrders PRIMARY KEY,

    OrderNumber NVARCHAR(50) NOT NULL,
    CustomerName NVARCHAR(200) NOT NULL,

    ProductCode NVARCHAR(50) NOT NULL,
    SteelGrade NVARCHAR(50) NOT NULL,

    TargetWidth DECIMAL(10,3) NOT NULL,
    TargetThickness DECIMAL(10,4) NOT NULL,
    TargetWeight DECIMAL(18,2) NOT NULL,

    Quantity INT NOT NULL,

    Status NVARCHAR(30) NOT NULL,

    CreatedDate DATETIME2 NOT NULL,
    DueDate DATETIME2 NULL,

    CONSTRAINT UQ_ProductionOrders_OrderNumber
        UNIQUE (OrderNumber)
);
GO

