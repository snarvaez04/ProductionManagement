
namespace ProductionManagement.Shared.DTOs
{
    public sealed class ProductionOrderListDto
    {
        public int Id { get; init; }

        public string OrderNumber { get; init; } = string.Empty;

        public string CustomerName { get; init; } = string.Empty;

        public string ProductCode { get; init; } = string.Empty;

        public string SteelGrade { get; init; } = string.Empty;

        public decimal TargetWidth { get; init; }

        public decimal TargetThickness { get; init; }

        public decimal TargetWeight { get; init; }

        public int Quantity { get; init; }

        public string Status { get; init; } = string.Empty;

        public DateTime CreatedDate { get; init; }

        public DateTime? DueDate { get; init; }

        public int CoilCount { get; init; }

        public decimal ProducedWeight { get; init; }

        public int ReleasedCoilCount { get; init; }

        public int OnHoldCoilCount { get; init; }
    }
}
