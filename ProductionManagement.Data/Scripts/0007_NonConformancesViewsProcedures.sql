CREATE VIEW dbo.vw_NonConformanceList
AS
SELECT
    nc.Id,
    nc.NCNumber,

    nc.CoilId,
    c.CoilNumber,

    nc.QualityInspectionId,

    nc.Type,
    nc.Description,
    nc.Severity,
    nc.Status,
    nc.Disposition,

    nc.CreatedDate,
    nc.ResolvedDate

FROM dbo.NonConformances AS nc

INNER JOIN dbo.Coils AS c
    ON c.Id = nc.CoilId;
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
        END,
        CreatedDate DESC;
END;
GO

CREATE PROCEDURE dbo.usp_NonConformance_GetByCoil
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
        Type,
        Description,
        Severity,
        Status,
        Disposition,
        CreatedDate,
        ResolvedDate
    FROM dbo.vw_NonConformanceList
    WHERE CoilId = @CoilId
    ORDER BY
        CreatedDate DESC;
END;
GO

CREATE PROCEDURE dbo.usp_NonConformance_GetById
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

CREATE PROCEDURE dbo.usp_NonConformance_Create
    @NCNumber NVARCHAR(50),
    @CoilId INT,
    @QualityInspectionId INT = NULL,
    @Type NVARCHAR(100),
    @Description NVARCHAR(2000),
    @Severity NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

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


CREATE PROCEDURE dbo.usp_NonConformance_Update
    @Id INT,
    @Type NVARCHAR(100),
    @Description NVARCHAR(2000),
    @Severity NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.NonConformances
    SET
        Type = @Type,
        Description = @Description,
        Severity = @Severity
    WHERE Id = @Id;
END;
GO

CREATE PROCEDURE dbo.usp_NonConformance_Resolve
    @Id INT,
    @Disposition NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.NonConformances
    SET
        Status = 'Resolved',
        Disposition = @Disposition,
        ResolvedDate = SYSUTCDATETIME()
    WHERE Id = @Id;
END;
GO

CREATE PROCEDURE dbo.usp_NonConformance_Close
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.NonConformances
    SET
        Status = 'Closed'
    WHERE Id = @Id;
END;
GO
