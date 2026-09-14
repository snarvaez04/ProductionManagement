
namespace ProductionManagement.Shared.DTOs
{
    public sealed class UpdateCoilRequest
    {
        public int Id { get; init; }

        public decimal Weight { get; init; }

        public decimal Width { get; init; }

        public decimal Thickness { get; init; }

        public string? CurrentLocation { get; init; }
    }
}
