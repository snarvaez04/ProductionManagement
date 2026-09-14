
namespace ProductionManagement.Shared.DTOs
{
    public sealed class CreateNonConformanceRequest
    {
        public int CoilId { get; init; }

        public int? QualityInspectionId { get; init; }

        public string Type { get; init; } = string.Empty;

        public string Description { get; init; } = string.Empty;

        public string Severity { get; init; } = string.Empty;
    }
}
