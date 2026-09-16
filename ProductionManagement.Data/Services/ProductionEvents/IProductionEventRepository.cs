using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface IProductionEventRepository
    {
        Task<List<ProductionEventListDto>> GetListAsync();

        Task<ProductionEventDto?> GetByIdAsync(int id);

        Task<List<ProductionEventDto>> GetByCoilAsync(int coilId);

        Task<List<ProductionEventDto>> GetByEquipmentAsync(int equipmentId);

        Task<int> CreateAsync(CreateProductionEventRequest request);
    }
}
