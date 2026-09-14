CREATE VIEW dbo.vw_QualityInspectionList
AS
SELECT
    qi.Id,
    qi.CoilId,
    c.CoilNumber,
    qi.InspectionDate,
    qi.InspectorName,
    qi.Result,
    qi.SurfaceQuality,
    qi.WidthMeasured,
    qi.ThicknessMeasured,
    qi.WeightMeasured,
    qi.Notes

FROM dbo.QualityInspections AS qi
INNER JOIN dbo.Coils AS c
    ON c.Id = qi.CoilId;
GO

CREATE OR ALTER PROCEDURE dbo.usp_QualityInspection_GetList
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        CoilId,
        CoilNumber,
        InspectionDate,
        InspectorName,
        Result,
        SurfaceQuality,
        WidthMeasured,
        ThicknessMeasured,
        WeightMeasured,
        Notes
    FROM dbo.vw_QualityInspectionList
    ORDER BY InspectionDate DESC;
END;
GO


CREATE PROCEDURE dbo.usp_QualityInspection_GetByCoil
    @CoilId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        CoilId,
        CoilNumber,
        InspectionDate,
        InspectorName,
        Result,
        SurfaceQuality,
        WidthMeasured,
        ThicknessMeasured,
        WeightMeasured,
        Notes
    FROM dbo.vw_QualityInspectionList
    WHERE CoilId = @CoilId
    ORDER BY InspectionDate DESC;
END;
GO

CREATE PROCEDURE dbo.usp_QualityInspection_GetById
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        CoilId,
        CoilNumber,
        InspectionDate,
        InspectorName,
        Result,
        SurfaceQuality,
        WidthMeasured,
        ThicknessMeasured,
        WeightMeasured,
        Notes
    FROM dbo.vw_QualityInspectionList
    WHERE Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_QualityInspection_Create
    @CoilId INT,
    @InspectorName NVARCHAR(200),
    @Result NVARCHAR(30),
    @SurfaceQuality NVARCHAR(100) = NULL,
    @WidthMeasured DECIMAL(10,3) = NULL,
    @ThicknessMeasured DECIMAL(10,4) = NULL,
    @WeightMeasured DECIMAL(18,2) = NULL,
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
        ;THROW 50030,
            'The specified coil does not exist.',
            1;
    END;

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectorName,
        Result,
        SurfaceQuality,
        WidthMeasured,
        ThicknessMeasured,
        WeightMeasured,
        Notes
    )
    VALUES
    (
        @CoilId,
        @InspectorName,
        @Result,
        @SurfaceQuality,
        @WidthMeasured,
        @ThicknessMeasured,
        @WeightMeasured,
        @Notes
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO


