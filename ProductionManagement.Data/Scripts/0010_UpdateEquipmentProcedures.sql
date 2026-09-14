CREATE OR ALTER PROCEDURE dbo.usp_Equipment_Update
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

    IF @@ROWCOUNT = 0
    BEGIN
        ;THROW 50010,
            'Equipment was not found.',
            1;
    END;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_Equipment_SetOperational
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Equipment
    SET
        Status = 'Operational'
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        ;THROW 50011,
            'Equipment was not found.',
            1;
    END;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_Equipment_SetMaintenance
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Equipment
    SET
        Status = 'Maintenance'
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        ;THROW 50012,
            'Equipment was not found.',
            1;
    END;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_Equipment_SetDown
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Equipment
    SET
        Status = 'Down'
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        ;THROW 50013,
            'Equipment was not found.',
            1;
    END;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_Equipment_SetOffline
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Equipment
    SET
        Status = 'Offline'
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        ;THROW 50014,
            'Equipment was not found.',
            1;
    END;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_Equipment_Delete
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Equipment
        WHERE Id = @Id
    )
    BEGIN
        ;THROW 50016,
            'Equipment was not found.',
            1;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.ProductionEvents
        WHERE EquipmentId = @Id
    )
    BEGIN
        ;THROW 50015,
            'Equipment cannot be deleted because production history references it.',
            1;
    END;

    DELETE FROM dbo.Equipment
    WHERE Id = @Id;
END;
GO
