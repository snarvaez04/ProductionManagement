using Dapper;
using ProductionManagement.Data.Context;
using ProductionManagement.Shared.DTOs;
using System.Data;

namespace ProductionManagement.Data.Services
{
    public sealed class QualityInspectionRepository : IQualityInspectionRepository
    {
        private readonly IDbConnectionFactory _connectionFactory;

        public QualityInspectionRepository(
            IDbConnectionFactory connectionFactory)
        {
            _connectionFactory = connectionFactory;
        }

        public async Task<IEnumerable<QualityInspectionListDto>> GetListAsync()
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QueryAsync<QualityInspectionListDto>(
                "dbo.usp_QualityInspection_GetList",
                commandType: CommandType.StoredProcedure);
        }

        public async Task<QualityInspectionDetailsDto?> GetByIdAsync(
            int id)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QuerySingleOrDefaultAsync<
                QualityInspectionDetailsDto>(
                    "dbo.usp_QualityInspection_GetById",
                    new
                    {
                        Id = id
                    },
                    commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<QualityInspectionDetailsDto>>
            GetByCoilAsync(int coilId)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.QueryAsync<
                QualityInspectionDetailsDto>(
                    "dbo.usp_QualityInspection_GetByCoil",
                    new
                    {
                        CoilId = coilId
                    },
                    commandType: CommandType.StoredProcedure);
        }

        public async Task<int> CreateAsync(
            CreateQualityInspectionRequest request)
        {
            using var connection = _connectionFactory.CreateConnection();

            return await connection.ExecuteScalarAsync<int>(
                "dbo.usp_QualityInspection_Create",
                new
                {
                    request.CoilId,
                    request.InspectorName,
                    request.Result,
                    request.SurfaceQuality,
                    request.WidthMeasured,
                    request.ThicknessMeasured,
                    request.WeightMeasured,
                    request.Notes
                },
                commandType: CommandType.StoredProcedure);
        }
    }
}
