
namespace ProductionManagement.Shared.DTOs
{
    public sealed class CreateCoilRequest
    {
        public string CoilNumber { get; init; } = string.Empty;

        public int ProductionOrderId { get; init; }

        public decimal Weight { get; init; }

        public decimal Width { get; init; }

        public decimal Thickness { get; init; }

        public string SteelGrade { get; init; } = string.Empty;

        public string? CurrentLocation { get; init; }
    }
}
