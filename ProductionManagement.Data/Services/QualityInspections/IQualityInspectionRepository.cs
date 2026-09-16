using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface IQualityInspectionRepository
    {
        Task<List<QualityInspectionListDto>> GetListAsync();

        Task<QualityInspectionDetailsDto?> GetByIdAsync(int id);

        Task<List<QualityInspectionDetailsDto>> GetByCoilAsync(int coilId);

        Task<int> CreateAsync(CreateQualityInspectionRequest request);
    }
}
