
namespace ProductionManagement.Shared.DTOs
{
    public sealed class QualityInspectionListDto
    {
        public int Id { get; init; }

        public int CoilId { get; init; }

        public string CoilNumber { get; init; } = string.Empty;

        public DateTime InspectionDate { get; init; }

        public string InspectorName { get; init; } = string.Empty;

        public string Result { get; init; } = string.Empty;

        public string? SurfaceQuality { get; init; }

        public decimal? WidthMeasured { get; init; }

        public decimal? ThicknessMeasured { get; init; }

        public decimal? WeightMeasured { get; init; }

        public string? Notes { get; init; }
    }
}
