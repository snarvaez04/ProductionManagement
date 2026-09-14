
namespace ProductionManagement.Shared.DTOs
{
    public sealed class CoilDetailsDto
    {
        public int Id { get; init; }

        public string CoilNumber { get; init; } = string.Empty;

        public int ProductionOrderId { get; init; }

        public string ProductionOrderNumber { get; init; } = string.Empty;

        public string CustomerName { get; init; } = string.Empty;

        public string ProductCode { get; init; } = string.Empty;

        public string SteelGrade { get; init; } = string.Empty;

        public decimal Weight { get; init; }

        public decimal Width { get; init; }

        public decimal Thickness { get; init; }

        public string Status { get; init; } = string.Empty;

        public string? CurrentLocation { get; init; }

        public DateTime CreatedDate { get; init; }

        public DateTime? CompletedDate { get; init; }

        public decimal TargetWidth { get; init; }

        public decimal TargetThickness { get; init; }

        public decimal TargetWeight { get; init; }

        public DateTime? ProductionOrderDueDate { get; init; }
    }
}
