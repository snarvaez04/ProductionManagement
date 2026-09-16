using ProductionManagement.Client.Helpers;
using ProductionManagement.Shared.DTOs;
using System.Net.Http.Json;

namespace ProductionManagement.Client.Services;

public sealed class QualityInspectionApiClient
{
    private readonly HttpClient _http;

    public QualityInspectionApiClient(HttpClient http) => _http = http;

    public async Task<IReadOnlyList<QualityInspectionListDto>> GetListAsync(CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<List<QualityInspectionListDto>>("api/QualityInspections", cancellationToken) ?? [];

    public Task<QualityInspectionDetailsDto?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        => _http.GetFromJsonAsync<QualityInspectionDetailsDto>($"api/QualityInspections/{id}", cancellationToken);

    public async Task<IReadOnlyList<QualityInspectionDetailsDto>> GetByCoilAsync(int coilId, CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<List<QualityInspectionDetailsDto>>($"api/QualityInspections/coil/{coilId}", cancellationToken) ?? [];

    public async Task<int> CreateAsync(CreateQualityInspectionRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _http.PostAsJsonAsync("api/QualityInspections", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
        return await response.Content.ReadFromJsonAsync<int>(cancellationToken: cancellationToken);
    }
}
