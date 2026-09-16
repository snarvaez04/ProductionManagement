using Dapper;
using ProductionManagement.Data.Context;
using ProductionManagement.Shared.DTOs;
using System.Data;

namespace ProductionManagement.Data.Services
{
    public sealed class ProductionEventRepository : IProductionEventRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public ProductionEventRepository(
            IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<List<ProductionEventListDto>> GetListAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            return (await connection.QueryAsync<ProductionEventListDto>(
                "dbo.usp_ProductionEvent_GetList",
                commandType: CommandType.StoredProcedure)).AsList();
        }

        public async Task<ProductionEventDto?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QuerySingleOrDefaultAsync<ProductionEventDto>(
                "dbo.usp_ProductionEvent_GetById",
                new
                {
                    Id = id
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task<List<ProductionEventDto>> GetByCoilAsync(int coilId)
        {
            using var connection = _connectionFactory.CreateConnection();

            return (await connection.QueryAsync<ProductionEventDto>(
                "dbo.usp_ProductionEvent_GetByCoil",
                new
                {
                    CoilId = coilId
                },
                commandType: CommandType.StoredProcedure)).AsList();
        }

        public async Task<List<ProductionEventDto>> GetByEquipmentAsync(int equipmentId)
        {
            using var connection = _connectionFactory.CreateConnection();

            return (await connection.QueryAsync<ProductionEventDto>(
                "dbo.usp_ProductionEvent_GetByEquipment",
                new
                {
                    EquipmentId = equipmentId
                },
                commandType: CommandType.StoredProcedure)).AsList();
        }

        public async Task<int> CreateAsync(CreateProductionEventRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(
                "dbo.usp_ProductionEvent_Create",
                new
                {
                    request.CoilId,
                    request.EquipmentId,
                    request.EventType,
                    request.EventDate,
                    request.OperatorName,
                    request.Notes
                },
                commandType: CommandType.StoredProcedure);
        }
    }
}
