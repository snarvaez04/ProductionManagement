using ProductionManagement.Client.Helpers;
using ProductionManagement.Shared.DTOs;
using System.Net.Http.Json;

namespace ProductionManagement.Client.Services;

public sealed class EquipmentApiClient
{
    private readonly HttpClient _http;

    public EquipmentApiClient(HttpClient http) => _http = http;

    public async Task<IEnumerable<EquipmentListDto>> GetListAsync(CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<IEnumerable<EquipmentListDto>>("api/equipment", cancellationToken) ?? [];

    public Task<EquipmentDetailsDto?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        => _http.GetFromJsonAsync<EquipmentDetailsDto>($"api/equipment/{id}", cancellationToken);

    public async Task<int> CreateAsync(CreateEquipmentRequest request, CancellationToken cancellationToken = default)
    {
        using var response = await _http.PostAsJsonAsync("api/equipment", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
        return await response.Content.ReadFromJsonAsync<int>(cancellationToken);
    }

    public async Task UpdateAsync(int id, UpdateEquipmentRequest request, CancellationToken cancellationToken = default)
    {
        using var response = await _http.PutAsJsonAsync($"api/equipment/{id}", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
    }

    public async Task SetOperationalAsync(int id, CancellationToken cancellationToken = default)
        => await PostStatusAsync($"api/equipment/{id}/operational", cancellationToken);

    public async Task SetMaintenanceAsync(int id, CancellationToken cancellationToken = default)
        => await PostStatusAsync($"api/equipment/{id}/maintenance", cancellationToken);

    public async Task SetDownAsync(int id, CancellationToken cancellationToken = default)
        => await PostStatusAsync($"api/equipment/{id}/down", cancellationToken);

    public async Task SetOfflineAsync(int id, CancellationToken cancellationToken = default)
        => await PostStatusAsync($"api/equipment/{id}/offline", cancellationToken);

    public async Task DeleteAsync(int id, CancellationToken cancellationToken = default)
    {
        using var response = await _http.DeleteAsync($"api/equipment/{id}", cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
    }

    private async Task PostStatusAsync(string url, CancellationToken cancellationToken)
    {
        using var response = await _http.PostAsync(url, null, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
    }
}
