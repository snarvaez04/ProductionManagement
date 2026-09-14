
namespace ProductionManagement.Shared.DTOs
{
    public sealed class UpdateEquipmentRequest
    {
        public string Name { get; init; } = string.Empty;

        public string EquipmentType { get; init; } = string.Empty;

        public string Location { get; init; } = string.Empty;
    }
}
