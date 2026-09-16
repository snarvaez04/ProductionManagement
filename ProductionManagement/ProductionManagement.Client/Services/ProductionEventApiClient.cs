using ProductionManagement.Client.Helpers;
using ProductionManagement.Shared.DTOs;
using System.Net.Http.Json;

namespace ProductionManagement.Client.Services;

public sealed class ProductionEventApiClient
{
    private readonly HttpClient _http;

    public ProductionEventApiClient(HttpClient http) => _http = http;

    public async Task<IEnumerable<ProductionEventListDto>> GetListAsync(CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<IEnumerable<ProductionEventListDto>>("api/productionevents", cancellationToken) ?? [];

    public Task<ProductionEventDto?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        => _http.GetFromJsonAsync<ProductionEventDto>($"api/productionevents/{id}", cancellationToken);

    public async Task<IEnumerable<ProductionEventDto>> GetByCoilAsync(int coilId, CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<IEnumerable<ProductionEventDto>>($"api/productionevents/coil/{coilId}", cancellationToken) ?? [];

    public async Task<IEnumerable<ProductionEventDto>> GetByEquipmentAsync(int equipmentId, CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<IEnumerable<ProductionEventDto>>($"api/productionevents/equipment/{equipmentId}", cancellationToken) ?? [];

    public async Task<int> CreateAsync(CreateProductionEventRequest request, CancellationToken cancellationToken = default)
    {
        using var response = await _http.PostAsJsonAsync("api/productionevents", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
        return await response.Content.ReadFromJsonAsync<int>(cancellationToken);
    }
}
