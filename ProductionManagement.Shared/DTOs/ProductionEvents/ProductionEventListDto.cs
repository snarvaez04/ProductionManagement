
namespace ProductionManagement.Shared.DTOs
{
    public sealed class ProductionEventListDto
    {
        public int Id { get; init; }

        public string CoilNumber { get; init; } = string.Empty;

        public string? EquipmentNumber { get; init; }

        public string? EquipmentName { get; init; }

        public string EventType { get; init; } = string.Empty;

        public DateTime EventDate { get; init; }

        public string? OperatorName { get; init; }

        public string? Notes { get; init; }
    }
}
