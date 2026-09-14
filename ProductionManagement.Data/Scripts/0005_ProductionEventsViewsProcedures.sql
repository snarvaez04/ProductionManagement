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


CREATE OR ALTER PROCEDURE dbo.usp_ProductionEvent_GetList
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
    ORDER BY EventDate DESC;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_ProductionEvent_GetById
    @Id INT
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
    WHERE Id = @Id;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_ProductionEvent_GetByCoil
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
    ORDER BY EventDate DESC;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_ProductionEvent_GetByEquipment
    @EquipmentId INT
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
    WHERE EquipmentId = @EquipmentId
    ORDER BY EventDate DESC;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_ProductionEvent_Create
    @CoilId INT,
    @EquipmentId INT = NULL,
    @EventType NVARCHAR(50),
    @EventDate DATETIME2 = NULL,
    @OperatorName NVARCHAR(200) = NULL,
    @Notes NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Coils
        WHERE Id = @CoilId
    )
    BEGIN
        ;THROW 50020,
            'The specified coil does not exist.',
            1;
    END;

    IF @EquipmentId IS NOT NULL
       AND NOT EXISTS
       (
           SELECT 1
           FROM dbo.Equipment
           WHERE Id = @EquipmentId
       )
    BEGIN
        ;THROW 50021,
            'The specified equipment does not exist.',
            1;
    END;

    INSERT INTO dbo.ProductionEvents
    (
        CoilId,
        EquipmentId,
        EventType,
        EventDate,
        OperatorName,
        Notes
    )
    VALUES
    (
        @CoilId,
        @EquipmentId,
        @EventType,
        COALESCE(@EventDate, SYSUTCDATETIME()),
        @OperatorName,
        @Notes
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO


CREATE OR ALTER TRIGGER dbo.trg_ProductionEvents_UpdateCoilStatus
ON dbo.ProductionEvents
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET
        Status =
            CASE i.EventType
                WHEN 'Processing Started'
                    THEN 'In Production'

                WHEN 'Quality Hold'
                    THEN 'On Hold'

                WHEN 'Quality Released'
                    THEN 'Released'

                WHEN 'Production Completed'
                    THEN 'Completed'

                ELSE c.Status
            END
    FROM dbo.Coils AS c
    INNER JOIN inserted AS i
        ON i.CoilId = c.Id
    WHERE i.EventType IN
    (
        'Processing Started',
        'Quality Hold',
        'Quality Released',
        'Production Completed'
    );
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_ProductionEvent_GetByEquipment
    @EquipmentId INT
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
    WHERE EquipmentId = @EquipmentId
    ORDER BY
        EventDate DESC;
END;
GO
