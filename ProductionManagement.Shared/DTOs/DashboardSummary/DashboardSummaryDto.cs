namespace ProductionManagement.Shared.DTOs
{
    public class DashboardSummaryDto
    {
        public int ActiveProductionOrders { get; init; }

        public int CompletedProductionOrders { get; init; }

        public int TotalCoils { get; init; }

        public int CoilsInProduction { get; init; }

        public int CoilsAwaitingInspection { get; init; }

        public int CoilsOnHold { get; init; }

        public int ReleasedCoils { get; init; }

        public decimal TotalProductionWeight { get; init; }

        public int OpenNonConformances { get; init; }

        public int CriticalNonConformances { get; init; }

        public int MajorNonConformances { get; init; }

        public int TotalEquipment { get; init; }

        public int OperationalEquipment { get; init; }

        public int EquipmentInMaintenance { get; init; }

        public int EquipmentDown { get; init; }

        public int EquipmentOffline { get; init; }
    }
}
