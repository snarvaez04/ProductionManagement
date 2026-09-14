using Dapper;
using ProductionManagement.Data.Context;
using ProductionManagement.Shared.DTOs;
using System.Data;

namespace ProductionManagement.Data.Services
{
    public sealed class CoilRepository : ICoilRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public CoilRepository(IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IEnumerable<CoilListDto>> GetListAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QueryAsync<CoilListDto>(
                "dbo.usp_Coil_GetList",
                commandType: CommandType.StoredProcedure);
        }

        public async Task<CoilDetailsDto?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QuerySingleOrDefaultAsync<CoilDetailsDto>(
                "dbo.usp_Coil_GetById",
                new { Id = id },
                commandType: CommandType.StoredProcedure);
        }

        public async Task<int> CreateAsync(CreateCoilRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(
                "dbo.usp_Coil_Create",
                new
                {
                    request.CoilNumber,
                    request.ProductionOrderId,
                    request.Weight,
                    request.Width,
                    request.Thickness,
                    request.SteelGrade,
                    request.CurrentLocation
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task UpdateAsync(UpdateCoilRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_Coil_Update",
                new
                {
                    request.Id,
                    request.Weight,
                    request.Width,
                    request.Thickness,
                    request.CurrentLocation
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task ChangeStatusAsync(int id, string status)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_Coil_ChangeStatus",
                new
                {
                    Id = id,
                    Status = status
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task DeleteAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_Coil_Delete",
                new { Id = id },
                commandType: CommandType.StoredProcedure);
        }
    }

}
