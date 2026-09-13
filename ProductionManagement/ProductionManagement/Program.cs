using ProductionManagement.Data.Extensions;
using ProductionManagement.Components;
using ProductionManagement.Components.Layout;
using MudBlazor.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

var connectionString = builder.Configuration.GetConnectionString("ProductionManagement")
    ?? throw new InvalidOperationException("Connection string not found.");

//Migrate database
DatabaseMigrator.Migrate(connectionString);

//Register DBContext and data services
ServiceRegistrations.AddDataServices(builder.Services, connectionString);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveWebAssemblyComponents();

builder.Services.AddMudServices();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseWebAssemblyDebugging();
}
else
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
app.UseStatusCodePagesWithReExecute("/not-found", createScopeForStatusCodePages: true);
app.UseHttpsRedirection();

app.UseRouting();
app.UseAntiforgery();
app.MapControllers();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveWebAssemblyRenderMode()
    .AddAdditionalAssemblies(typeof(ProductionManagement.Client._Imports).Assembly);

app.Run();
