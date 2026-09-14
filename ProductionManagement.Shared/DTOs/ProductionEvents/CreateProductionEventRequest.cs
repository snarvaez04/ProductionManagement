
namespace ProductionManagement.Shared.DTOs
{
    public sealed class CreateProductionEventRequest
    {
        public int CoilId { get; init; }

        public int? EquipmentId { get; init; }

        public string EventType { get; init; } = string.Empty;

        public DateTime? EventDate { get; init; }

        public string? OperatorName { get; init; }

        public string? Notes { get; init; }
    }
}
