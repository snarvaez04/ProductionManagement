using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using MudBlazor.Services;
using ProductionManagement.Client.Services;


var builder = WebAssemblyHostBuilder.CreateDefault(args);

builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });

builder.Services.AddMudServices();
builder.Services.AddScoped<DashboardApiClient>();
builder.Services.AddScoped<ProductionOrderApiClient>();
builder.Services.AddScoped<CoilApiClient>();
builder.Services.AddScoped<QualityInspectionApiClient>();
builder.Services.AddScoped<NonConformanceApiClient>();
builder.Services.AddScoped<EquipmentApiClient>();
builder.Services.AddScoped<ProductionEventApiClient>();


await builder.Build().RunAsync();
