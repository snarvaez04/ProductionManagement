
namespace ProductionManagement.Shared.DTOs
{
    public sealed class CreateCoilRequest
    {
        public int Id { get; set; }

        public string CoilNumber { get; set; } = string.Empty;

        public int ProductionOrderId { get; set; }

        public decimal Weight { get; set; }

        public decimal Width { get; set; }

        public decimal Thickness { get; set; }

        public string SteelGrade { get; set; } = string.Empty;

        public string? CurrentLocation { get; set; }
    }
}
