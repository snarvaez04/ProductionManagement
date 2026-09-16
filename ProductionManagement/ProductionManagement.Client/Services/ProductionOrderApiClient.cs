using ProductionManagement.Client.Helpers;
using ProductionManagement.Shared.DTOs;
using System.Net.Http.Json;

namespace ProductionManagement.Client.Services;

public sealed class ProductionOrderApiClient
{
    private readonly HttpClient _http;

    public ProductionOrderApiClient(HttpClient http) => _http = http;

    public async Task<IReadOnlyList<ProductionOrderListDto>> GetListAsync(CancellationToken cancellationToken = default)
        => await _http.GetFromJsonAsync<List<ProductionOrderListDto>>("api/ProductionOrders", cancellationToken) ?? [];

    public Task<ProductionOrderDetailsDto?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        => _http.GetFromJsonAsync<ProductionOrderDetailsDto>($"api/ProductionOrders/{id}", cancellationToken);

    public async Task<int> CreateAsync(CreateProductionOrderRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _http.PostAsJsonAsync("api/ProductionOrders", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
        return await response.Content.ReadFromJsonAsync<int>(cancellationToken: cancellationToken);
    }

    public async Task UpdateAsync(int id, UpdateProductionOrderRequest request, CancellationToken cancellationToken = default)
    {
        var response = await _http.PutAsJsonAsync($"api/ProductionOrders/{id}", request, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
    }

    public async Task ReleaseAsync(int id, CancellationToken cancellationToken = default)
        => await PostActionAsync($"api/ProductionOrders/{id}/release", cancellationToken);

    public async Task StartAsync(int id, CancellationToken cancellationToken = default)
        => await PostActionAsync($"api/ProductionOrders/{id}/start", cancellationToken);

    public async Task CompleteAsync(int id, CancellationToken cancellationToken = default)
        => await PostActionAsync($"api/ProductionOrders/{id}/complete", cancellationToken);

    public async Task DeleteAsync(int id, CancellationToken cancellationToken = default)
    {
        var response = await _http.DeleteAsync($"api/ProductionOrders/{id}", cancellationToken);
        response.EnsureSuccessStatusCode();
    }

    private async Task PostActionAsync(string uri, CancellationToken cancellationToken)
    {
        var response = await _http.PostAsync(uri, null, cancellationToken);
        await ApiHelper.EnsureSuccessAsync(response);
    }
}
