using Microsoft.Extensions.DependencyInjection;
using ProductionManagement.Data.Context;
using ProductionManagement.Data.Services;

namespace ProductionManagement.Data.Extensions
{
    public static class ServiceRegistrations
    {
        public static IServiceCollection AddDataServices(this IServiceCollection services, string connectionString)
        {
            services.AddSingleton<IDbContext>(new DbContext(connectionString));

            return services;
        }
    }
}
