
namespace ProductionManagement.Shared.DTOs
{
    public sealed class CreateEquipmentRequest
    {
        public string EquipmentNumber { get; init; } = string.Empty;

        public string Name { get; init; } = string.Empty;

        public string EquipmentType { get; init; } = string.Empty;

        public string Location { get; init; } = string.Empty;
    }
}
