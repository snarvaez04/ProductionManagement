using System.Net.Http.Json;
using ProductionManagement.Shared.DTOs;
using ProductionManagement.Shared.DTOs.DashboardSummary;

namespace ProductionManagement.Client.Services;

public sealed class DashboardApiClient(HttpClient httpClient)
{
    public async Task<DashboardSummaryDto?> GetSummaryAsync(CancellationToken cancellationToken = default)
        => await httpClient.GetFromJsonAsync<DashboardSummaryDto>("api/Dashboard/summary", cancellationToken);

    public async Task<IReadOnlyList<DashboardRecentActivityDto>> GetRecentActivityAsync(int top = 10, CancellationToken cancellationToken = default)
        => await httpClient.GetFromJsonAsync<List<DashboardRecentActivityDto>>($"api/Dashboard/recent-activity?top={top}", cancellationToken)
           ?? [];
}
