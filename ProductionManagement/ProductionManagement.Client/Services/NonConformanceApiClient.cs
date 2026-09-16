using ProductionManagement.Client.Helpers;
using ProductionManagement.Shared.DTOs;
using System.Net.Http.Json;

namespace ProductionManagement.Client.Services;

public sealed class NonConformanceApiClient
{
    private readonly HttpClient _http;

    public NonConformanceApiClient(HttpClient http) => _http = http;

    public async Task<IReadOnlyList<NonConformanceListDto>> GetListAsync(CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<List<NonConformanceListDto>>("api/NonConformances", cancellationToken) ?? [];

    public Task<NonConformanceDetailsDto?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        => _http.GetFromJsonAsync<NonConformanceDetailsDto>($"api/NonConformances/{id}", cancellationToken);

    public async Task<IReadOnlyList<NonConformanceListDto>> GetByCoilAsync(int coilId, CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<List<NonConformanceListDto>>($"api/NonConformances/coil/{coilId}", cancellationToken) ?? [];

    public async Task<int> CreateAsync(CreateNonConformanceRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _http.PostAsJsonAsync("api/NonConformances", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
        return await response.Content.ReadFromJsonAsync<int>(cancellationToken: cancellationToken);
    }

    public async Task UpdateAsync(int id, UpdateNonConformanceRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _http.PutAsJsonAsync($"api/NonConformances/{id}", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
    }
}
