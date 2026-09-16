CREATE OR ALTER VIEW dbo.vw_ProductionOrderList
AS
SELECT
    po.Id,
    po.OrderNumber,
    po.CustomerName,
    po.ProductCode,
    po.SteelGrade,
    po.TargetWidth,
    po.TargetThickness,
    po.TargetWeight,
    po.Quantity,
    po.Status,
    po.CreatedDate,
    po.DueDate,

    COUNT(c.Id) AS CoilCount,

    COALESCE
    (
        SUM
        (
            CASE
                WHEN c.Status = 'Completed' OR c.Status = 'Released'
                THEN c.Weight
                ELSE 0
            END
        ),
        0
    ) AS ProducedWeight,

    SUM
    (
        CASE
            WHEN c.Status = 'Released'
            THEN 1
            ELSE 0
        END
    ) AS ReleasedCoilCount,

    SUM
    (
        CASE
            WHEN c.Status = 'On Hold'
            THEN 1
            ELSE 0
        END
    ) AS OnHoldCoilCount

FROM dbo.ProductionOrders AS po
LEFT JOIN dbo.Coils AS c
    ON c.ProductionOrderId = po.Id

GROUP BY
    po.Id,
    po.OrderNumber,
    po.CustomerName,
    po.ProductCode,
    po.SteelGrade,
    po.TargetWidth,
    po.TargetThickness,
    po.TargetWeight,
    po.Quantity,
    po.Status,
    po.CreatedDate,
    po.DueDate;
GO



CREATE OR ALTER PROCEDURE dbo.usp_ProductionOrder_GetList
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        OrderNumber,
        CustomerName,
        ProductCode,
        SteelGrade,
        TargetWidth,
        TargetThickness,
        TargetWeight,
        Quantity,
        Status,
        CreatedDate,
        DueDate,
        CoilCount,
        ProducedWeight,
        ReleasedCoilCount,
        OnHoldCoilCount
    FROM dbo.vw_ProductionOrderList
    ORDER BY
        DueDate,
        OrderNumber;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_ProductionOrder_GetById
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        OrderNumber,
        CustomerName,
        ProductCode,
        SteelGrade,
        TargetWidth,
        TargetThickness,
        TargetWeight,
        Quantity,
        Status,
        CreatedDate,
        DueDate,
        CoilCount,
        ProducedWeight,
        ReleasedCoilCount,
        OnHoldCoilCount
    FROM dbo.vw_ProductionOrderList
    WHERE Id = @Id;
END;
GO


CREATE PROCEDURE dbo.usp_ProductionOrder_Create
    @OrderNumber NVARCHAR(50),
    @CustomerName NVARCHAR(200),
    @ProductCode NVARCHAR(50),
    @SteelGrade NVARCHAR(50),
    @TargetWidth DECIMAL(10,3),
    @TargetThickness DECIMAL(10,4),
    @TargetWeight DECIMAL(18,2),
    @Quantity INT,
    @DueDate DATETIME2 = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.ProductionOrders
    (
        OrderNumber,
        CustomerName,
        ProductCode,
        SteelGrade,
        TargetWidth,
        TargetThickness,
        TargetWeight,
        Quantity,
        DueDate
    )
    VALUES
    (
        @OrderNumber,
        @CustomerName,
        @ProductCode,
        @SteelGrade,
        @TargetWidth,
        @TargetThickness,
        @TargetWeight,
        @Quantity,
        @DueDate
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO


CREATE PROCEDURE dbo.usp_ProductionOrder_Update
    @Id INT,
    @CustomerName NVARCHAR(200),
    @ProductCode NVARCHAR(50),
    @SteelGrade NVARCHAR(50),
    @TargetWidth DECIMAL(10,3),
    @TargetThickness DECIMAL(10,4),
    @TargetWeight DECIMAL(18,2),
    @Quantity INT,
    @DueDate DATETIME2 = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.ProductionOrders
    SET
        CustomerName = @CustomerName,
        ProductCode = @ProductCode,
        SteelGrade = @SteelGrade,
        TargetWidth = @TargetWidth,
        TargetThickness = @TargetThickness,
        TargetWeight = @TargetWeight,
        Quantity = @Quantity,
        DueDate = @DueDate
    WHERE Id = @Id;
END;
GO


CREATE PROCEDURE dbo.usp_ProductionOrder_ChangeStatus
    @Id INT,
    @Status NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.ProductionOrders
    SET
        Status = @Status
    WHERE Id = @Id;
END;
GO


CREATE PROCEDURE dbo.usp_ProductionOrder_Delete
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Coils
        WHERE ProductionOrderId = @Id
    )
    BEGIN
        ;THROW 50001,
            'Production order cannot be deleted because coils are associated with it.',
            1;
    END;

    DELETE FROM dbo.ProductionOrders
    WHERE Id = @Id;
END;
GO
