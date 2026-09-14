CREATE OR ALTER VIEW dbo.vw_NonConformanceList
AS
SELECT
    nc.Id,
    nc.NCNumber,
    nc.CoilId,
    c.CoilNumber,
    nc.QualityInspectionId,
    qi.InspectionDate,
    qi.Result AS InspectionResult,
    nc.Type,
    nc.Description,
    nc.Severity,
    nc.Status,
    nc.Disposition,
    nc.CreatedDate,
    nc.ResolvedDate
FROM dbo.NonConformances AS nc
INNER JOIN dbo.Coils AS c
    ON c.Id = nc.CoilId
LEFT JOIN dbo.QualityInspections AS qi
    ON qi.Id = nc.QualityInspectionId;
GO


CREATE PROCEDURE dbo.usp_NonConformance_GetList
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        NCNumber,
        CoilId,
        CoilNumber,
        QualityInspectionId,
        Type,
        Description,
        Severity,
        Status,
        Disposition,
        CreatedDate,
        ResolvedDate
    FROM dbo.vw_NonConformanceList
    ORDER BY
        CASE Severity
            WHEN 'Critical' THEN 1
            WHEN 'Major' THEN 2
            WHEN 'Minor' THEN 3
            ELSE 4
        END,
        CreatedDate DESC;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_NonConformance_GetById
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        NCNumber,
        CoilId,
        CoilNumber,
        QualityInspectionId,
        InspectionDate,
        InspectionResult,
        Type,
        Description,
        Severity,
        Status,
        Disposition,
        CreatedDate,
        ResolvedDate
    FROM dbo.vw_NonConformanceList
    WHERE Id = @Id;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_NonConformance_GetByCoil
    @CoilId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        NCNumber,
        CoilId,
        CoilNumber,
        QualityInspectionId,
        InspectionDate,
        InspectionResult,
        Type,
        Description,
        Severity,
        Status,
        Disposition,
        CreatedDate,
        ResolvedDate
    FROM dbo.vw_NonConformanceList
    WHERE CoilId = @CoilId
    ORDER BY CreatedDate DESC;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_NonConformance_Create
    @CoilId INT,
    @QualityInspectionId INT = NULL,
    @Type NVARCHAR(100),
    @Description NVARCHAR(2000),
    @Severity NVARCHAR(30)
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
        ;THROW 50050,
            'The specified coil does not exist.',
            1;
    END;

    IF @QualityInspectionId IS NOT NULL
       AND NOT EXISTS
       (
           SELECT 1
           FROM dbo.QualityInspections
           WHERE Id = @QualityInspectionId
             AND CoilId = @CoilId
       )
    BEGIN
        ;THROW 50051,
            'The specified quality inspection does not belong to the specified coil.',
            1;
    END;

    DECLARE @NextNumber INT;

    SELECT
        @NextNumber =
            ISNULL(
                MAX(
                    TRY_CONVERT(
                        INT,
                        REPLACE(NCNumber, 'NC-', '')
                    )
                ),
                0
            ) + 1
    FROM dbo.NonConformances;

    DECLARE @NCNumber NVARCHAR(50);

    SET @NCNumber =
        'NC-' +
        RIGHT(
            '000000' + CAST(@NextNumber AS VARCHAR(6)),
            6
        );

    INSERT INTO dbo.NonConformances
    (
        NCNumber,
        CoilId,
        QualityInspectionId,
        Type,
        Description,
        Severity
    )
    VALUES
    (
        @NCNumber,
        @CoilId,
        @QualityInspectionId,
        @Type,
        @Description,
        @Severity
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_NonConformance_Update
    @Id INT,
    @Status NVARCHAR(30),
    @Disposition NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.NonConformances
        WHERE Id = @Id
    )
    BEGIN
        ;THROW 50052,
            'Non-conformance was not found.',
            1;
    END;

    IF @Status NOT IN
    (
        'Open',
        'Investigating',
        'Resolved',
        'Closed'
    )
    BEGIN
        ;THROW 50053,
            'Invalid non-conformance status.',
            1;
    END;

    UPDATE dbo.NonConformances
    SET
        Status = @Status,
        Disposition = @Disposition,
        ResolvedDate =
            CASE
                WHEN @Status IN ('Resolved', 'Closed')
                    THEN COALESCE(
                        ResolvedDate,
                        SYSUTCDATETIME()
                    )
                ELSE NULL
            END
    WHERE Id = @Id;
END;
GO
