CREATE VIEW dbo.vw_CoilList
AS
SELECT
    c.Id,
    c.CoilNumber,
    c.ProductionOrderId,
    po.OrderNumber AS ProductionOrderNumber,
    po.CustomerName,
    c.SteelGrade,
    c.Weight,
    c.Width,
    c.Thickness,
    c.Status,
    c.CurrentLocation,
    c.CreatedDate,
    c.CompletedDate
FROM dbo.Coils AS c
INNER JOIN dbo.ProductionOrders AS po
    ON po.Id = c.ProductionOrderId;
GO

CREATE VIEW dbo.vw_CoilDetails
AS
SELECT
    c.Id,
    c.CoilNumber,
    c.ProductionOrderId,
    po.OrderNumber AS ProductionOrderNumber,
    po.CustomerName,
    po.ProductCode,
    c.SteelGrade,
    c.Weight,
    c.Width,
    c.Thickness,
    c.Status,
    c.CurrentLocation,
    c.CreatedDate,
    c.CompletedDate,
    po.TargetWidth,
    po.TargetThickness,
    po.TargetWeight,
    po.DueDate AS ProductionOrderDueDate
FROM dbo.Coils AS c
INNER JOIN dbo.ProductionOrders AS po
    ON po.Id = c.ProductionOrderId;
GO

CREATE PROCEDURE dbo.usp_Coil_GetList
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        CoilNumber,
        ProductionOrderId,
        ProductionOrderNumber,
        CustomerName,
        SteelGrade,
        Weight,
        Width,
        Thickness,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    FROM dbo.vw_CoilList
    ORDER BY CoilNumber;
END;
GO

CREATE PROCEDURE dbo.usp_Coil_GetById
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        CoilNumber,
        ProductionOrderId,
        ProductionOrderNumber,
        CustomerName,
        ProductCode,
        SteelGrade,
        Weight,
        Width,
        Thickness,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate,
        TargetWidth,
        TargetThickness,
        TargetWeight,
        ProductionOrderDueDate
    FROM dbo.vw_CoilDetails
    WHERE Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_Coil_Create
    @CoilNumber NVARCHAR(50),
    @ProductionOrderId INT,
    @Weight DECIMAL(18,2),
    @Width DECIMAL(10,3),
    @Thickness DECIMAL(10,4),
    @SteelGrade NVARCHAR(50),
    @CurrentLocation NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.ProductionOrders
        WHERE Id = @ProductionOrderId
    )
    BEGIN
        ;THROW 50041,
            'The specified production order does not exist.',
            1;
    END;

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        CurrentLocation
    )
    VALUES
    (
        @CoilNumber,
        @ProductionOrderId,
        @Weight,
        @Width,
        @Thickness,
        @SteelGrade,
        @CurrentLocation
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO



CREATE OR ALTER PROCEDURE dbo.usp_Coil_Update
    @Id INT,
    @Weight DECIMAL(18,2),
    @Width DECIMAL(10,3),
    @Thickness DECIMAL(10,4),
    @CurrentLocation NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Coils
        WHERE Id = @Id
    )
    BEGIN
        ;THROW 50042,
            'Coil was not found.',
            1;
    END;

    UPDATE dbo.Coils
    SET
        Weight = @Weight,
        Width = @Width,
        Thickness = @Thickness,
        CurrentLocation = @CurrentLocation
    WHERE Id = @Id;
END;
GO


CREATE TABLE dbo.CoilAudit
(
    Id INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_CoilAudit PRIMARY KEY,

    CoilId INT NOT NULL,

    OldStatus NVARCHAR(30) NULL,

    NewStatus NVARCHAR(30) NOT NULL,

    ChangedDate DATETIME2 NOT NULL
        CONSTRAINT DF_CoilAudit_ChangedDate
        DEFAULT SYSUTCDATETIME(),

    ChangeType NVARCHAR(20) NOT NULL,

    CONSTRAINT FK_CoilAudit_Coils
        FOREIGN KEY (CoilId)
        REFERENCES dbo.Coils(Id)
        ON DELETE CASCADE
);
GO


CREATE TRIGGER dbo.trg_Coils_StatusAudit
ON dbo.Coils
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.CoilAudit
    (
        CoilId,
        OldStatus,
        NewStatus,
        ChangedDate,
        ChangeType
    )
    SELECT
        i.Id,
        d.Status,
        i.Status,
        SYSUTCDATETIME(),
        'STATUS_CHANGE'
    FROM inserted AS i
    INNER JOIN deleted AS d
        ON d.Id = i.Id
    WHERE ISNULL(i.Status, '') <> ISNULL(d.Status, '');
END;
GO

CREATE PROCEDURE dbo.usp_Coil_Delete
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.ProductionEvents
        WHERE CoilId = @Id
    )
    BEGIN
        ;THROW 50040,
            'Coil cannot be deleted because production history exists.',
            1;
    END;

    DELETE FROM dbo.Coils
    WHERE Id = @Id;
END;
GO


