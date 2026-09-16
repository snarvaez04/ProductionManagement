CREATE OR ALTER VIEW dbo.vw_DashboardProductionSummary
AS
SELECT
    COUNT
    (
        CASE
            WHEN Status = 'Approved'
            THEN 1
        END
    ) AS ActiveProductionOrders,

    COUNT
    (
        CASE
            WHEN Status = 'Completed'
            THEN 1
        END
    ) AS CompletedProductionOrders

FROM dbo.ProductionOrders;
GO



CREATE OR ALTER VIEW dbo.vw_DashboardCoilSummary
AS
SELECT

    COUNT(*) AS TotalCoils,

    COUNT
    (
        CASE
            WHEN Status = 'In Production'
            THEN 1
        END
    ) AS CoilsInProduction,

    COUNT
    (
        CASE
            WHEN Status = 'On Hold'
            THEN 1
        END
    ) AS CoilsOnHold,

    COUNT
    (
        CASE
            WHEN Status = 'Released'
            THEN 1
        END
    ) AS ReleasedCoils,

    COUNT
    (
        CASE
            WHEN Status = 'Completed'
            THEN 1
        END
    ) AS CompletedCoils,

    COUNT
    (
        CASE
            WHEN Status = 'Scrapped'
            THEN 1
        END
    ) AS ScrappedCoils,

    COALESCE(SUM(Weight), 0) AS TotalProductionWeight

FROM dbo.Coils;
GO



CREATE OR ALTER VIEW dbo.vw_DashboardNonConformanceSummary
AS
SELECT

    COUNT
    (
        CASE
            WHEN Status IN ('Open', 'Investigating')
            THEN 1
        END
    ) AS OpenNonConformances,

    COUNT
    (
        CASE
            WHEN Severity = 'Critical'
                 AND Status IN ('Open', 'Investigating')
            THEN 1
        END
    ) AS CriticalNonConformances,

    COUNT
    (
        CASE
            WHEN Severity = 'Major'
                 AND Status IN ('Open', 'Investigating')
            THEN 1
        END
    ) AS MajorNonConformances,

    COUNT
    (
        CASE
            WHEN Status = 'Resolved'
            THEN 1
        END
    ) AS ResolvedNonConformances,

    COUNT
    (
        CASE
            WHEN Status = 'Closed'
            THEN 1
        END
    ) AS ClosedNonConformances

FROM dbo.NonConformances;
GO



CREATE VIEW dbo.vw_DashboardEquipmentSummary
AS
SELECT

    COUNT(*) AS TotalEquipment,

    COUNT
    (
        CASE
            WHEN Status = 'Operational'
            THEN 1
        END
    ) AS OperationalEquipment,

    COUNT
    (
        CASE
            WHEN Status = 'Maintenance'
            THEN 1
        END
    ) AS EquipmentInMaintenance,

    COUNT
    (
        CASE
            WHEN Status = 'Down'
            THEN 1
        END
    ) AS EquipmentDown,

    COUNT
    (
        CASE
            WHEN Status = 'Offline'
            THEN 1
        END
    ) AS EquipmentOffline

FROM dbo.Equipment;
GO


CREATE OR ALTER PROCEDURE dbo.usp_Dashboard_GetSummary
AS
BEGIN
    SET NOCOUNT ON;

    SELECT

        -- Production Orders
        po.ActiveProductionOrders,
        po.CompletedProductionOrders,

        -- Coils
        c.TotalCoils,
        c.CoilsInProduction,
        c.CoilsOnHold,
        c.ReleasedCoils,
        c.CompletedCoils,
        c.ScrappedCoils,
        c.TotalProductionWeight,

        -- Non-Conformances
        nc.OpenNonConformances,
        nc.CriticalNonConformances,
        nc.MajorNonConformances,
        nc.ResolvedNonConformances,
        nc.ClosedNonConformances,

        -- Equipment
        e.TotalEquipment,
        e.OperationalEquipment,
        e.EquipmentInMaintenance,
        e.EquipmentDown,
        e.EquipmentOffline

    FROM dbo.vw_DashboardProductionSummary AS po

    CROSS JOIN dbo.vw_DashboardCoilSummary AS c

    CROSS JOIN dbo.vw_DashboardNonConformanceSummary AS nc

    CROSS JOIN dbo.vw_DashboardEquipmentSummary AS e;
END;
GO


CREATE PROCEDURE dbo.usp_Dashboard_GetRecentActivity
    @Top INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@Top)
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
