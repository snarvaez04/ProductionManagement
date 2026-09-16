
SET NOCOUNT ON;

BEGIN TRANSACTION;

BEGIN TRY

    /* ========================================================
       1. EQUIPMENT
       ======================================================== */

    INSERT INTO dbo.Equipment
    (
        EquipmentNumber,
        Name,
        EquipmentType,
        Location,
        Status
    )
    VALUES
        ('EAF-01', 'Electric Arc Furnace 1', 'Furnace', 'Steelmaking', 'Operational'),
        ('EAF-02', 'Electric Arc Furnace 2', 'Furnace', 'Steelmaking', 'Operational'),
        ('HSM-01', 'Hot Strip Mill 1', 'Rolling Mill', 'Hot Rolling', 'Operational'),
        ('CAST-01', 'Continuous Caster 1', 'Caster', 'Casting', 'Operational'),
        ('GALV-01', 'Galvanizing Line 1', 'Coating Line', 'Finishing', 'Operational'),
        ('GALV-02', 'Galvanizing Line 2', 'Coating Line', 'Finishing', 'Maintenance');


    /* ========================================================
       2. PRODUCTION ORDERS
       ======================================================== */

    DECLARE @PO1 INT;
    DECLARE @PO2 INT;
    DECLARE @PO3 INT;
    DECLARE @PO4 INT;
    DECLARE @PO5 INT;

    /* --------------------------------------------------------
       PO-2026-1001 - In Production
       -------------------------------------------------------- */

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
        Status,
        CreatedDate,
        DueDate
    )
    VALUES
    (
        'PO-2026-1001',
        'Gulf Coast Manufacturing',
        'HR-A36-060',
        'A36',
        60.000,
        0.1250,
        5000.00,
        10,
        'In Production',
        '2026-09-10',
        '2026-09-20'
    );

    SET @PO1 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       PO-2026-1002 - Approved
       -------------------------------------------------------- */

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
        Status,
        CreatedDate,
        DueDate
    )
    VALUES
    (
        'PO-2026-1002',
        'Lone Star Fabrication',
        'HR-A572-072',
        'A572 Grade 50',
        72.000,
        0.1870,
        7500.00,
        12,
        'Approved',
        '2026-09-11',
        '2026-09-24'
    );

    SET @PO2 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       PO-2026-1003 - Approved
       -------------------------------------------------------- */

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
        Status,
        CreatedDate,
        DueDate
    )
    VALUES
    (
        'PO-2026-1003',
        'Rio Grande Industrial',
        'HR-A1011-048',
        'A1011',
        48.000,
        0.1000,
        3500.00,
        8,
        'Approved',
        '2026-09-12',
        '2026-09-22'
    );

    SET @PO3 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       PO-2026-1004 - Draft
       -------------------------------------------------------- */

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
        Status,
        CreatedDate,
        DueDate
    )
    VALUES
    (
        'PO-2026-1004',
        'South Texas Steel Products',
        'HSLA-060',
        'HSLA 50',
        60.000,
        0.1500,
        6000.00,
        10,
        'Draft',
        '2026-09-13',
        '2026-09-28'
    );

    SET @PO4 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       PO-2026-1005 - Completed
       -------------------------------------------------------- */

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
        Status,
        CreatedDate,
        DueDate
    )
    VALUES
    (
        'PO-2026-1005',
        'Gulf Coast Manufacturing',
        'HR-A36-048',
        'A36',
        48.000,
        0.1250,
        4000.00,
        8,
        'Completed',
        '2026-09-05',
        '2026-09-15'
    );

    SET @PO5 = SCOPE_IDENTITY();


    /* ========================================================
       3. COILS
       ======================================================== */

    DECLARE @Coil1 INT;
    DECLARE @Coil2 INT;
    DECLARE @Coil3 INT;
    DECLARE @Coil4 INT;
    DECLARE @Coil5 INT;
    DECLARE @Coil6 INT;
    DECLARE @Coil7 INT;
    DECLARE @Coil8 INT;
    DECLARE @Coil9 INT;
    DECLARE @Coil10 INT;


    /* --------------------------------------------------------
       Coil 1 - Released
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260901-001',
        @PO1,
        21.40,
        60.000,
        0.1240,
        'A36',
        'Released',
        'Finished Goods - Rack A',
        '2026-09-14 08:15',
        '2026-09-14 09:05'
    );

    SET @Coil1 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 2 - Released
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260901-002',
        @PO1,
        22.10,
        60.000,
        0.1260,
        'A36',
        'Released',
        'Finished Goods - Rack A',
        '2026-09-14 09:20',
        '2026-09-14 10:10'
    );

    SET @Coil2 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 3 - On Hold
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260901-003',
        @PO1,
        20.80,
        60.000,
        0.1380,
        'A36',
        'On Hold',
        'Quality Hold Area',
        '2026-09-14 10:30',
        '2026-09-14 11:15'
    );

    SET @Coil3 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 4 - In Production
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260901-004',
        @PO1,
        21.70,
        60.000,
        0.1250,
        'A36',
        'In Production',
        'Hot Strip Mill',
        '2026-09-14 11:30',
        NULL
    );

    SET @Coil4 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 5 - Completed
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260901-005',
        @PO2,
        23.50,
        72.000,
        0.1860,
        'A572 Grade 50',
        'Completed',
        'Quality Inspection',
        '2026-09-14 13:00',
        '2026-09-14 13:50'
    );

    SET @Coil5 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 6 - Created
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260901-006',
        @PO2,
        24.10,
        72.000,
        0.1880,
        'A572 Grade 50',
        'Created',
        'Production Queue',
        '2026-09-14 14:10',
        NULL
    );

    SET @Coil6 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 7 - Released
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260902-001',
        @PO3,
        19.80,
        48.000,
        0.1000,
        'A1011',
        'Released',
        'Finished Goods - Rack B',
        '2026-09-15 07:30',
        '2026-09-15 08:20'
    );

    SET @Coil7 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 8 - Completed
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260902-002',
        @PO3,
        20.30,
        48.000,
        0.1010,
        'A1011',
        'Completed',
        'Quality Inspection',
        '2026-09-15 08:40',
        '2026-09-15 09:25'
    );

    SET @Coil8 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 9 - On Hold
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260902-003',
        @PO3,
        19.60,
        48.000,
        0.1030,
        'A1011',
        'On Hold',
        'Quality Hold Area',
        '2026-09-15 09:45',
        '2026-09-15 10:30'
    );

    SET @Coil9 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 10 - In Production
       -------------------------------------------------------- */

    INSERT INTO dbo.Coils
    (
        CoilNumber,
        ProductionOrderId,
        Weight,
        Width,
        Thickness,
        SteelGrade,
        Status,
        CurrentLocation,
        CreatedDate,
        CompletedDate
    )
    VALUES
    (
        'C-260902-004',
        @PO4,
        22.70,
        60.000,
        0.1500,
        'HSLA 50',
        'In Production',
        'Hot Strip Mill',
        '2026-09-15 11:00',
        NULL
    );

    SET @Coil10 = SCOPE_IDENTITY();


    /* ========================================================
       4. QUALITY INSPECTIONS
       ======================================================== */

    DECLARE @Inspection1 INT;
    DECLARE @Inspection2 INT;
    DECLARE @Inspection3 INT;
    DECLARE @Inspection4 INT;
    DECLARE @Inspection5 INT;
    DECLARE @Inspection6 INT;
    DECLARE @Inspection7 INT;
    DECLARE @Inspection8 INT;
    DECLARE @Inspection9 INT;


    /* --------------------------------------------------------
       Coil 1 - Pass
       -------------------------------------------------------- */

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectionDate,
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
        @Coil1,
        '2026-09-14 09:15',
        'Mike Rodriguez',
        'Pass',
        'Good',
        60.010,
        0.1240,
        21.40,
        'All measurements within specification.'
    );

    SET @Inspection1 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 2 - Pass
       -------------------------------------------------------- */

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectionDate,
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
        @Coil2,
        '2026-09-14 10:20',
        'Mike Rodriguez',
        'Pass',
        'Good',
        60.000,
        0.1260,
        22.10,
        'Coil passed routine inspection.'
    );

    SET @Inspection2 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 3 - Fail
       -------------------------------------------------------- */

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectionDate,
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
        @Coil3,
        '2026-09-14 11:25',
        'Sarah Thompson',
        'Fail',
        'Good',
        60.020,
        0.1380,
        20.80,
        'Thickness exceeds upper specification limit.'
    );

    SET @Inspection3 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 4 - Pass
       -------------------------------------------------------- */

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectionDate,
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
        @Coil4,
        '2026-09-14 12:20',
        'Sarah Thompson',
        'Pass',
        'Good',
        60.000,
        0.1250,
        21.70,
        'Initial inspection passed.'
    );

    SET @Inspection4 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 5 - Pass
       -------------------------------------------------------- */

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectionDate,
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
        @Coil5,
        '2026-09-14 14:00',
        'David Lee',
        'Pass',
        'Good',
        72.010,
        0.1860,
        23.50,
        'Measurements within tolerance.'
    );

    SET @Inspection5 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 7 - Pass
       -------------------------------------------------------- */

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectionDate,
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
        @Coil7,
        '2026-09-15 08:30',
        'Mike Rodriguez',
        'Pass',
        'Good',
        48.000,
        0.1000,
        19.80,
        'Coil passed inspection.'
    );

    SET @Inspection6 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 8 - Pass
       -------------------------------------------------------- */

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectionDate,
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
        @Coil8,
        '2026-09-15 09:35',
        'Mike Rodriguez',
        'Pass',
        'Good',
        48.010,
        0.1010,
        20.30,
        'Coil passed inspection.'
    );

    SET @Inspection7 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 9 - Fail
       -------------------------------------------------------- */

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectionDate,
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
        @Coil9,
        '2026-09-15 10:40',
        'Sarah Thompson',
        'Fail',
        'Surface Defect',
        48.000,
        0.1030,
        19.60,
        'Surface defect detected during visual inspection.'
    );

    SET @Inspection8 = SCOPE_IDENTITY();


    /* --------------------------------------------------------
       Coil 10 - Pass
       -------------------------------------------------------- */

    INSERT INTO dbo.QualityInspections
    (
        CoilId,
        InspectionDate,
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
        @Coil10,
        '2026-09-15 12:00',
        'David Lee',
        'Pass',
        'Good',
        60.000,
        0.1500,
        22.70,
        'Initial inspection passed.'
    );

    SET @Inspection9 = SCOPE_IDENTITY();


    /* ========================================================
       5. NON-CONFORMANCES
       ======================================================== */

    INSERT INTO dbo.NonConformances
    (
        NCNumber,
        CoilId,
        QualityInspectionId,
        Type,
        Description,
        Severity,
        Status,
        Disposition,
        CreatedDate,
        ResolvedDate
    )
    VALUES
    (
        'NC-2026-001',
        @Coil3,
        @Inspection3,
        'Thickness',
        'Coil thickness measured above the specified upper tolerance.',
        'High',
        'Investigating',
        'Pending',
        '2026-09-14 11:30',
        NULL
    );


    INSERT INTO dbo.NonConformances
    (
        NCNumber,
        CoilId,
        QualityInspectionId,
        Type,
        Description,
        Severity,
        Status,
        Disposition,
        CreatedDate,
        ResolvedDate
    )
    VALUES
    (
        'NC-2026-002',
        @Coil9,
        @Inspection8,
        'Surface Quality',
        'Surface defect detected during final visual inspection.',
        'Medium',
        'Open',
        'Pending',
        '2026-09-15 10:45',
        NULL
    );


    /* ========================================================
       6. PRODUCTION EVENTS
       ======================================================== */

    INSERT INTO dbo.ProductionEvents
    (
        CoilId,
        EquipmentId,
        EventType,
        EventDate,
        OperatorName,
        Notes
    )
    SELECT
        @Coil1,
        Id,
        'Production Complete',
        '2026-09-14 09:05',
        'John Smith',
        'Coil successfully completed production.'
    FROM dbo.Equipment
    WHERE EquipmentNumber = 'HSM-01';


    INSERT INTO dbo.ProductionEvents
    (
        CoilId,
        EquipmentId,
        EventType,
        EventDate,
        OperatorName,
        Notes
    )
    SELECT
        @Coil2,
        Id,
        'Quality Released',
        '2026-09-14 10:25',
        'John Smith',
        'Coil passed quality inspection and was released.'
    FROM dbo.Equipment
    WHERE EquipmentNumber = 'HSM-01';


    INSERT INTO dbo.ProductionEvents
    (
        CoilId,
        EquipmentId,
        EventType,
        EventDate,
        OperatorName,
        Notes
    )
    SELECT
        @Coil3,
        Id,
        'Quality Hold',
        '2026-09-14 11:30',
        'Sarah Thompson',
        'Coil placed on hold following failed thickness inspection.'
    FROM dbo.Equipment
    WHERE EquipmentNumber = 'HSM-01';


    INSERT INTO dbo.ProductionEvents
    (
        CoilId,
        EquipmentId,
        EventType,
        EventDate,
        OperatorName,
        Notes
    )
    SELECT
        @Coil7,
        Id,
        'Quality Released',
        '2026-09-15 08:35',
        'Mike Rodriguez',
        'Coil passed inspection and was released.'
    FROM dbo.Equipment
    WHERE EquipmentNumber = 'HSM-01';


    INSERT INTO dbo.ProductionEvents
    (
        CoilId,
        EquipmentId,
        EventType,
        EventDate,
        OperatorName,
        Notes
    )
    SELECT
        @Coil9,
        Id,
        'Quality Hold',
        '2026-09-15 10:45',
        'Sarah Thompson',
        'Coil placed on hold due to surface defect.'
    FROM dbo.Equipment
    WHERE EquipmentNumber = 'HSM-01';


    /* ========================================================
       7. COIL AUDIT
       ======================================================== */

    INSERT INTO dbo.CoilAudit
    (
        CoilId,
        OldStatus,
        NewStatus,
        ChangedDate,
        ChangeType
    )
    VALUES
        (
            @Coil1,
            'Completed',
            'Released',
            '2026-09-14 09:20',
            'Status'
        ),
        (
            @Coil2,
            'Completed',
            'Released',
            '2026-09-14 10:25',
            'Status'
        ),
        (
            @Coil3,
            'Completed',
            'On Hold',
            '2026-09-14 11:30',
            'Status'
        ),
        (
            @Coil7,
            'Completed',
            'Released',
            '2026-09-15 08:35',
            'Status'
        ),
        (
            @Coil9,
            'Completed',
            'On Hold',
            '2026-09-15 10:45',
            'Status'
        );


    /* ========================================================
       COMPLETE TRANSACTION
       ======================================================== */

    COMMIT TRANSACTION;

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    THROW;

END CATCH;
GO