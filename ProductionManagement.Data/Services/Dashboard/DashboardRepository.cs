using Dapper;
using ProductionManagement.Data.Context;
using ProductionManagement.Shared.DTOs;
using System.Data;

namespace ProductionManagement.Data.Services
{
    public sealed class DashboardRepository : IDashboardRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public DashboardRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<DashboardSummaryDto?> GetSummaryAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QuerySingleOrDefaultAsync<DashboardSummaryDto>(
                "dbo.usp_Dashboard_GetSummary",
                commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<ProductionEventDto>> GetRecentActivityAsync(int top = 10)
        {
            using var connection = _connectionFactory.CreateConnection();

            var parameters = new DynamicParameters();
            parameters.Add("@Top", top);

            var results = await connection.QueryAsync<ProductionEventDto>(
                "dbo.usp_Dashboard_GetRecentActivity",
                parameters,
                commandType: CommandType.StoredProcedure);

            return results.AsList();
        }
    }
}
