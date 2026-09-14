
namespace ProductionManagement.Shared.DTOs
{
    public sealed class UpdateNonConformanceRequest
    {
        public string Status { get; init; } = string.Empty;

        public string Disposition { get; init; } = string.Empty;
    }
}
