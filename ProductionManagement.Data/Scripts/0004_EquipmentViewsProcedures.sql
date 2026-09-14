CREATE VIEW dbo.vw_EquipmentList
AS
SELECT
    e.Id,
    e.EquipmentNumber,
    e.Name,
    e.EquipmentType,
    e.Location,
    e.Status,

    COUNT(pe.Id) AS ProductionEventCount,

    MAX(pe.EventDate) AS LastActivityDate

FROM dbo.Equipment AS e

LEFT JOIN dbo.ProductionEvents AS pe
    ON pe.EquipmentId = e.Id

GROUP BY
    e.Id,
    e.EquipmentNumber,
    e.Name,
    e.EquipmentType,
    e.Location,
    e.Status;
GO

CREATE PROCEDURE dbo.usp_Equipment_GetList
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        EquipmentNumber,
        Name,
        EquipmentType,
        Location,
        Status,
        ProductionEventCount,
        LastActivityDate
    FROM dbo.vw_EquipmentList
    ORDER BY
        EquipmentNumber;
END;
GO

CREATE PROCEDURE dbo.usp_Equipment_GetById
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        EquipmentNumber,
        Name,
        EquipmentType,
        Location,
        Status
    FROM dbo.Equipment
    WHERE Id = @Id;
END;
GO

CREATE PROCEDURE dbo.usp_Equipment_Create
    @EquipmentNumber NVARCHAR(50),
    @Name NVARCHAR(200),
    @EquipmentType NVARCHAR(100),
    @Location NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Equipment
    (
        EquipmentNumber,
        Name,
        EquipmentType,
        Location
    )
    VALUES
    (
        @EquipmentNumber,
        @Name,
        @EquipmentType,
        @Location
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

CREATE PROCEDURE dbo.usp_Equipment_Update
    @Id INT,
    @Name NVARCHAR(200),
    @EquipmentType NVARCHAR(100),
    @Location NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Equipment
    SET
        Name = @Name,
        EquipmentType = @EquipmentType,
        Location = @Location
    WHERE Id = @Id;
END;
GO

CREATE PROCEDURE dbo.usp_Equipment_ChangeStatus
    @Id INT,
    @Status NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Equipment
    SET
        Status = @Status
    WHERE Id = @Id;
END;
GO

CREATE PROCEDURE dbo.usp_Equipment_Delete
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.ProductionEvents
        WHERE EquipmentId = @Id
    )
    BEGIN
        ;THROW 50002,
            'Equipment cannot be deleted because production history references it.',
            1;
    END;

    DELETE FROM dbo.Equipment
    WHERE Id = @Id;
END;
GO
