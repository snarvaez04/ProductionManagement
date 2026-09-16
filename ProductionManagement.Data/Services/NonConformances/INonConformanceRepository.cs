using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface INonConformanceRepository
    {
        Task<List<NonConformanceListDto>> GetListAsync();

        Task<NonConformanceDetailsDto?> GetByIdAsync(int id);

        Task<List<NonConformanceListDto>> GetByCoilAsync(int coilId);

        Task<int> CreateAsync(CreateNonConformanceRequest request);

        Task UpdateAsync(int id, UpdateNonConformanceRequest request);
    }
}
