using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface IQualityInspectionRepository
    {
        Task<IEnumerable<QualityInspectionListDto>> GetListAsync();

        Task<QualityInspectionDetailsDto?> GetByIdAsync(int id);

        Task<IEnumerable<QualityInspectionDetailsDto>> GetByCoilAsync(int coilId);

        Task<int> CreateAsync(CreateQualityInspectionRequest request);
    }
}
