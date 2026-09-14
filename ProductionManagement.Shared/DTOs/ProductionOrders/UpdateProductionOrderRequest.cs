
namespace ProductionManagement.Shared.DTOs
{
    public sealed class UpdateProductionOrderRequest
    {
        public int Id { get; init; }

        public string CustomerName { get; init; } = string.Empty;

        public string ProductCode { get; init; } = string.Empty;

        public string SteelGrade { get; init; } = string.Empty;

        public decimal TargetWidth { get; init; }

        public decimal TargetThickness { get; init; }

        public decimal TargetWeight { get; init; }

        public int Quantity { get; init; }

        public DateTime? DueDate { get; init; }
    }
}
