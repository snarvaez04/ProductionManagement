using Dapper;
using ProductionManagement.Data.Context;
using ProductionManagement.Shared.DTOs;
using System.Data;

namespace ProductionManagement.Data.Services
{
    public sealed class ProductionOrderRepository : IProductionOrderRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public ProductionOrderRepository(
            IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IEnumerable<ProductionOrderListDto>> GetListAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QueryAsync<ProductionOrderListDto>(
                "dbo.usp_ProductionOrder_GetList",
                commandType: CommandType.StoredProcedure);
        }

        public async Task<ProductionOrderDetailsDto?> GetByIdAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QuerySingleOrDefaultAsync<ProductionOrderDetailsDto>(
                "dbo.usp_ProductionOrder_GetById",
                new
                {
                    Id = id
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task<int> CreateAsync(CreateProductionOrderRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(
                "dbo.usp_ProductionOrder_Create",
                new
                {
                    request.OrderNumber,
                    request.CustomerName,
                    request.ProductCode,
                    request.SteelGrade,
                    request.TargetWidth,
                    request.TargetThickness,
                    request.TargetWeight,
                    request.Quantity,
                    request.DueDate
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task UpdateAsync(int id, UpdateProductionOrderRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_ProductionOrder_Update",
                new
                {
                    Id = id,
                    request.CustomerName,
                    request.ProductCode,
                    request.SteelGrade,
                    request.TargetWidth,
                    request.TargetThickness,
                    request.TargetWeight,
                    request.Quantity,
                    request.DueDate
                },
                commandType: CommandType.StoredProcedure);
        }

        public async Task ReleaseAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_ProductionOrder_Release",
                new { Id = id },
                commandType: CommandType.StoredProcedure);
        }

        public async Task StartProductionAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_ProductionOrder_StartProduction",
                new { Id = id },
                commandType: CommandType.StoredProcedure);
        }

        public async Task CompleteAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_ProductionOrder_Complete",
                new { Id = id },
                commandType: CommandType.StoredProcedure);
        }

        public async Task DeleteAsync(int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            await connection.ExecuteAsync(
                "dbo.usp_ProductionOrder_Delete",
                new
                {
                    Id = id
                },
                commandType: CommandType.StoredProcedure);
        }
    }
}
