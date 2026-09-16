using ProductionManagement.Client.Helpers;
using ProductionManagement.Shared.DTOs;
using System.Net.Http.Json;

namespace ProductionManagement.Client.Services;

public sealed class CoilApiClient
{
    private readonly HttpClient _http;

    public CoilApiClient(HttpClient http) => _http = http;

    public async Task<IReadOnlyList<CoilListDto>> GetListAsync(CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<List<CoilListDto>>("api/Coils", cancellationToken) ?? [];

    public Task<CoilDetailsDto?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        => _http.GetFromJsonAsync<CoilDetailsDto>($"api/Coils/{id}", cancellationToken);

    public async Task<int> CreateAsync(CreateCoilRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _http.PostAsJsonAsync("api/Coils", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
        return await response.Content.ReadFromJsonAsync<int>(cancellationToken: cancellationToken);
    }

    public async Task UpdateAsync(int id, UpdateCoilRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _http.PutAsJsonAsync($"api/Coils/{id}", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
    }

    public async Task DeleteAsync(int id, CancellationToken cancellationToken = default)
    {
        var response = await _http.DeleteAsync($"api/Coils/{id}", cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
    }
}
