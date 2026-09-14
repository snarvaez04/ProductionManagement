using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface IDashboardRepository
    {
        Task<DashboardSummaryDto?> GetSummaryAsync();
        Task<IEnumerable<ProductionEventDto>> GetRecentActivityAsync(int top = 10);
    }
}
