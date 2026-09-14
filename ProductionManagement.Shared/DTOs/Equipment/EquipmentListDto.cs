
namespace ProductionManagement.Shared.DTOs
{
    public sealed class EquipmentListDto
    {
        public int Id { get; init; }

        public string EquipmentNumber { get; init; } = string.Empty;

        public string Name { get; init; } = string.Empty;

        public string EquipmentType { get; init; } = string.Empty;

        public string Location { get; init; } = string.Empty;

        public string Status { get; init; } = string.Empty;

        public int ProductionEventCount { get; init; }

        public DateTime? LastActivityDate { get; init; }
    }
}
