using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface IProductionEventRepository
    {
        Task<IEnumerable<ProductionEventListDto>> GetListAsync();

        Task<ProductionEventDto?> GetByIdAsync(int id);

        Task<IEnumerable<ProductionEventDto>> GetByCoilAsync(int coilId);

        Task<IEnumerable<ProductionEventDto>> GetByEquipmentAsync(int equipmentId);

        Task<int> CreateAsync(CreateProductionEventRequest request);
    }
}
