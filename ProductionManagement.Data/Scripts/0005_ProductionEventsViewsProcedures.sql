CREATE VIEW dbo.vw_ProductionEventList
AS
SELECT
    pe.Id,
    pe.CoilId,
    c.CoilNumber,

    pe.EquipmentId,
    e.EquipmentNumber,
    e.Name AS EquipmentName,

    pe.EventType,
    pe.EventDate,
    pe.OperatorName,
    pe.Notes

FROM dbo.ProductionEvents AS pe

INNER JOIN dbo.Coils AS c
    ON c.Id = pe.CoilId

LEFT JOIN dbo.Equipment AS e
    ON e.Id = pe.EquipmentId;
GO

CREATE PROCEDURE dbo.usp_ProductionEvent_GetByCoil
    @CoilId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        CoilId,
        CoilNumber,
        EquipmentId,
        EquipmentNumber,
        EquipmentName,
        EventType,
        EventDate,
        OperatorName,
        Notes
    FROM dbo.vw_ProductionEventList
    WHERE CoilId = @CoilId
    ORDER BY
        EventDate;
END;
GO

CREATE PROCEDURE dbo.usp_ProductionEvent_Create
    @CoilId INT,
    @EquipmentId INT = NULL,
    @EventType NVARCHAR(50),
    @OperatorName NVARCHAR(200) = NULL,
    @Notes NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.ProductionEvents
    (
        CoilId,
        EquipmentId,
        EventType,
        OperatorName,
        Notes
    )
    VALUES
    (
        @CoilId,
        @EquipmentId,
        @EventType,
        @OperatorName,
        @Notes
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

