using Dapper;
using ProductionManagement.Data.Context;
using ProductionManagement.Shared.DTOs;
using System.Data;

namespace ProductionManagement.Data.Services
{
    public sealed class EquipmentRepository : IEquipmentRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public EquipmentRepository(
            IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<List<EquipmentListDto>> GetListAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            return (await connection.QueryAsync<EquipmentListDto>(
                "dbo.usp_Equipment_GetList",
                commandType: CommandType.StoredProcedure)).AsList();
        }

        public async Task<EquipmentDetailsDto?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QuerySingleOrDefaultAsync<EquipmentDetailsDto>(
                "dbo.usp_Equipment_GetById",
                new
                {
                    Id = id
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task<int> CreateAsync(CreateEquipmentRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(
                "dbo.usp_Equipment_Create",
                new
                {
                    request.EquipmentNumber,
                    request.Name,
                    request.EquipmentType,
                    request.Location
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task UpdateAsync(int Id, UpdateEquipmentRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_Equipment_Update",
                new
                {
                    Id = Id,
                    request.Name,
                    request.EquipmentType,
                    request.Location
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task SetOperationalAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_Equipment_SetOperational",
                new
                {
                    Id = id
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task SetMaintenanceAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_Equipment_SetMaintenance",
                new
                {
                    Id = id
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task SetDownAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_Equipment_SetDown",
                new
                {
                    Id = id
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task SetOfflineAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_Equipment_SetOffline",
                new
                {
                    Id = id
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task DeleteAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_Equipment_Delete",
                new
                {
                    Id = id
                },
                commandType: CommandType.StoredProcedure);
        }
    }
}
