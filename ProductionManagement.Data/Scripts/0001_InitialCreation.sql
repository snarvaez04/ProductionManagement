CREATE TABLE dbo.ProductionOrders
(
    Id INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_ProductionOrders PRIMARY KEY,

    OrderNumber NVARCHAR(50) NOT NULL,

    CustomerName NVARCHAR(200) NOT NULL,

    ProductCode NVARCHAR(50) NOT NULL,

    SteelGrade NVARCHAR(50) NOT NULL,

    TargetWidth DECIMAL(10,3) NOT NULL,

    TargetThickness DECIMAL(10,4) NOT NULL,

    TargetWeight DECIMAL(18,2) NOT NULL,

    Quantity INT NOT NULL,

    Status NVARCHAR(30) NOT NULL
        CONSTRAINT DF_ProductionOrders_Status
        DEFAULT 'Draft',

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_ProductionOrders_CreatedDate
        DEFAULT SYSUTCDATETIME(),

    DueDate DATETIME2 NULL,

    CONSTRAINT UQ_ProductionOrders_OrderNumber
        UNIQUE (OrderNumber)
);
GO

CREATE TABLE dbo.Coils
(
    Id INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Coils PRIMARY KEY,

    CoilNumber NVARCHAR(50) NOT NULL,

    ProductionOrderId INT NOT NULL,

    Weight DECIMAL(18,2) NOT NULL,

    Width DECIMAL(10,3) NOT NULL,

    Thickness DECIMAL(10,4) NOT NULL,

    SteelGrade NVARCHAR(50) NOT NULL,

    Status NVARCHAR(30) NOT NULL
        CONSTRAINT DF_Coils_Status
        DEFAULT 'Created',

    CurrentLocation NVARCHAR(100) NULL,

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_Coils_CreatedDate
        DEFAULT SYSUTCDATETIME(),

    CompletedDate DATETIME2 NULL,

    CONSTRAINT UQ_Coils_CoilNumber
        UNIQUE (CoilNumber),

    CONSTRAINT FK_Coils_ProductionOrders
        FOREIGN KEY (ProductionOrderId)
        REFERENCES dbo.ProductionOrders(Id),
);
GO

CREATE INDEX IX_Coils_ProductionOrderId
    ON dbo.Coils(ProductionOrderId);
GO

CREATE INDEX IX_Coils_Status
    ON dbo.Coils(Status);
GO

CREATE TABLE dbo.Equipment
(
    Id INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Equipment PRIMARY KEY,

    EquipmentNumber NVARCHAR(50) NOT NULL,

    Name NVARCHAR(200) NOT NULL,

    EquipmentType NVARCHAR(100) NOT NULL,

    Location NVARCHAR(100) NOT NULL,

    Status NVARCHAR(30) NOT NULL
        CONSTRAINT DF_Equipment_Status
        DEFAULT 'Operational',

    CONSTRAINT UQ_Equipment_EquipmentNumber
        UNIQUE (EquipmentNumber)
);
GO

CREATE TABLE dbo.ProductionEvents
(
    Id INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_ProductionEvents PRIMARY KEY,

    CoilId INT NOT NULL,

    EquipmentId INT NULL,

    EventType NVARCHAR(50) NOT NULL,

    EventDate DATETIME2 NOT NULL
        CONSTRAINT DF_ProductionEvents_EventDate
        DEFAULT SYSUTCDATETIME(),

    OperatorName NVARCHAR(200) NULL,

    Notes NVARCHAR(1000) NULL,

    CONSTRAINT FK_ProductionEvents_Coils
        FOREIGN KEY (CoilId)
        REFERENCES dbo.Coils(Id)
        ON DELETE CASCADE,

    CONSTRAINT FK_ProductionEvents_Equipment
        FOREIGN KEY (EquipmentId)
        REFERENCES dbo.Equipment(Id),
);
GO

CREATE INDEX IX_ProductionEvents_CoilId_EventDate
    ON dbo.ProductionEvents(CoilId, EventDate);
GO
CREATE INDEX IX_ProductionEvents_EquipmentId_EventDate
    ON dbo.ProductionEvents(EquipmentId, EventDate);
GO

CREATE TABLE dbo.QualityInspections
(
    Id INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_QualityInspections PRIMARY KEY,

    CoilId INT NOT NULL,

    InspectionDate DATETIME2 NOT NULL
        CONSTRAINT DF_QualityInspections_InspectionDate
        DEFAULT SYSUTCDATETIME(),

    InspectorName NVARCHAR(200) NOT NULL,

    Result NVARCHAR(30) NOT NULL,

    SurfaceQuality NVARCHAR(100) NULL,

    WidthMeasured DECIMAL(10,3) NULL,

    ThicknessMeasured DECIMAL(10,4) NULL,

    WeightMeasured DECIMAL(18,2) NULL,

    Notes NVARCHAR(1000) NULL,

    CONSTRAINT FK_QualityInspections_Coils
        FOREIGN KEY (CoilId)
        REFERENCES dbo.Coils(Id)
        ON DELETE CASCADE,
);

CREATE INDEX IX_QualityInspections_CoilId_InspectionDate
    ON dbo.QualityInspections(CoilId, InspectionDate);
GO

CREATE TABLE dbo.NonConformances
(
    Id INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_NonConformances PRIMARY KEY,

    NCNumber NVARCHAR(50) NOT NULL,

    CoilId INT NOT NULL,

    QualityInspectionId INT NULL,

    Type NVARCHAR(100) NOT NULL,

    Description NVARCHAR(2000) NOT NULL,

    Severity NVARCHAR(30) NOT NULL,

    Status NVARCHAR(30) NOT NULL
        CONSTRAINT DF_NonConformances_Status
        DEFAULT 'Open',

    Disposition NVARCHAR(30) NOT NULL
        CONSTRAINT DF_NonConformances_Disposition
        DEFAULT 'Pending',

    CreatedDate DATETIME2 NOT NULL
        CONSTRAINT DF_NonConformances_CreatedDate
        DEFAULT SYSUTCDATETIME(),

    ResolvedDate DATETIME2 NULL,

    CONSTRAINT UQ_NonConformances_NCNumber
        UNIQUE (NCNumber),

    CONSTRAINT FK_NonConformances_Coils
        FOREIGN KEY (CoilId)
        REFERENCES dbo.Coils(Id)
        ON DELETE CASCADE,

    CONSTRAINT FK_NonConformances_QualityInspections
        FOREIGN KEY (QualityInspectionId)
        REFERENCES dbo.QualityInspections(Id)
);
GO

CREATE INDEX IX_NonConformances_CoilId
    ON dbo.NonConformances(CoilId);
GO
CREATE INDEX IX_NonConformances_Status
    ON dbo.NonConformances(Status);
GO
CREATE INDEX IX_NonConformances_Status
    ON dbo.NonConformances(Status);
GO
