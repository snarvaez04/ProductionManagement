DROP PROCEDURE IF EXISTS dbo.usp_ProductionOrder_ChangeStatus;
GO

CREATE OR ALTER PROCEDURE dbo.usp_ProductionOrder_Release
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.ProductionOrders
    SET
        Status = 'Released'
    WHERE Id = @Id
      AND Status = 'Draft';

    IF @@ROWCOUNT = 0
    BEGIN
        ;THROW 50003,
            'Production order cannot be released because it does not exist or is not in Draft status.',
            1;
    END;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_ProductionOrder_StartProduction
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.ProductionOrders
    SET
        Status = 'InProduction'
    WHERE Id = @Id
      AND Status = 'Released';

    IF @@ROWCOUNT = 0
    BEGIN
        ;THROW 50004,
            'Production order cannot start because it does not exist or is not Released.',
            1;
    END;
END;
GO


CREATE OR ALTER PROCEDURE dbo.usp_ProductionOrder_Complete
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.ProductionOrders
    SET
        Status = 'Completed'
    WHERE Id = @Id
      AND Status = 'InProduction';

    IF @@ROWCOUNT = 0
    BEGIN
        ;THROW 50005,
            'Production order cannot be completed because it does not exist or is not InProduction.',
            1;
    END;
END;
GO