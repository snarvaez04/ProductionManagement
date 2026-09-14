
namespace ProductionManagement.Shared.DTOs
{
    public sealed class NonConformanceDetailsDto
    {
        public int Id { get; init; }

        public string NCNumber { get; init; } = string.Empty;

        public int CoilId { get; init; }

        public string CoilNumber { get; init; } = string.Empty;

        public int? QualityInspectionId { get; init; }

        public DateTime? InspectionDate { get; init; }

        public string? InspectionResult { get; init; }

        public string Type { get; init; } = string.Empty;

        public string Description { get; init; } = string.Empty;

        public string Severity { get; init; } = string.Empty;

        public string Status { get; init; } = string.Empty;

        public string Disposition { get; init; } = string.Empty;

        public DateTime CreatedDate { get; init; }

        public DateTime? ResolvedDate { get; init; }
    }
}
