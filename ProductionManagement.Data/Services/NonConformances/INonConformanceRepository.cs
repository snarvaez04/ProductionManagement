using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface INonConformanceRepository
    {
        Task<IEnumerable<NonConformanceListDto>> GetListAsync();

        Task<NonConformanceDetailsDto?> GetByIdAsync(int id);

        Task<IEnumerable<NonConformanceListDto>> GetByCoilAsync(int coilId);

        Task<int> CreateAsync(CreateNonConformanceRequest request);

        Task UpdateAsync(int id, UpdateNonConformanceRequest request);
    }
}
