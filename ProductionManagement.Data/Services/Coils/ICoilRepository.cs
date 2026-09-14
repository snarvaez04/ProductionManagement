using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface ICoilRepository
    {
        Task<IEnumerable<CoilListDto>> GetListAsync();

        Task<CoilDetailsDto?> GetByIdAsync(int id);

        Task<int> CreateAsync(CreateCoilRequest request);

        Task UpdateAsync(int Id, UpdateCoilRequest request);

        Task DeleteAsync(int id);
    }
}
