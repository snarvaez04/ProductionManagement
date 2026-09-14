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
    }
}
