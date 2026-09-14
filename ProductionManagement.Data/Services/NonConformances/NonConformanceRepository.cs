using Dapper;
using ProductionManagement.Data.Context;
using ProductionManagement.Shared.DTOs;
using System.Data;

namespace ProductionManagement.Data.Services
{
    public sealed class NonConformanceRepository : INonConformanceRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public NonConformanceRepository(
            IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IEnumerable<NonConformanceListDto>> GetListAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QueryAsync<NonConformanceListDto>(
                "dbo.usp_NonConformance_GetList",
                commandType: CommandType.StoredProcedure);
        }

        public async Task<NonConformanceDetailsDto?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QuerySingleOrDefaultAsync<
                NonConformanceDetailsDto>(
                    "dbo.usp_NonConformance_GetById",
                    new
                    {
                        Id = id
                    },
                    commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<NonConformanceListDto>>GetByCoilAsync(int coilId)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QueryAsync<NonConformanceListDto>(
                "dbo.usp_NonConformance_GetByCoil",
                new
                {
                    CoilId = coilId
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task<int> CreateAsync(CreateNonConformanceRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(
                "dbo.usp_NonConformance_Create",
                new
                {
                    request.CoilId,
                    request.QualityInspectionId,
                    request.Type,
                    request.Description,
                    request.Severity
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task UpdateAsync(int id, UpdateNonConformanceRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_NonConformance_Update",
                new
                {
                    Id = id,
                    request.Status,
                    request.Disposition
                },
                commandType: CommandType.StoredProcedure);
        }
    }
}
