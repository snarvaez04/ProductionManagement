
namespace ProductionManagement.Shared.DTOs.DashboardSummary
{
    public sealed class DashboardRecentActivityDto
    {
        public int Id { get; init; }

        public int CoilId { get; init; }

        public string CoilNumber { get; init; } = string.Empty;

        public int? EquipmentId { get; init; }

        public string? EquipmentNumber { get; init; }

        public string? EquipmentName { get; init; }

        public string EventType { get; init; } = string.Empty;

        public DateTime EventDate { get; init; }

        public string? OperatorName { get; init; }

        public string? Notes { get; init; }
    }

}
