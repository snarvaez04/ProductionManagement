using Microsoft.Extensions.DependencyInjection;
using ProductionManagement.Data.Context;
using ProductionManagement.Data.Services;

namespace ProductionManagement.Data.Extensions
{
    public static class ServiceRegistrations
    {
        public static IServiceCollection AddDataServices(this IServiceCollection services, string connectionString)
        {
            services.AddSingleton<IDbConnectionFactory>(new DbConnectionFactory(connectionString));
            services.AddScoped<ICoilRepository, CoilRepository>();
            services.AddScoped<IDashboardRepository, DashboardRepository>();
            services.AddScoped<IProductionOrderRepository,ProductionOrderRepository>();
            services.AddScoped<IEquipmentRepository,EquipmentRepository>();
            services.AddScoped<IProductionEventRepository,ProductionEventRepository>();
            services.AddScoped<IQualityInspectionRepository,QualityInspectionRepository>();
            services.AddScoped<INonConformanceRepository, NonConformanceRepository>();

            return services;
        }
    }
}
