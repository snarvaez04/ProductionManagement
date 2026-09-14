using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface IProductionOrderRepository
    {
        Task<IEnumerable<ProductionOrderListDto>> GetListAsync();

        Task<ProductionOrderDetailsDto?> GetByIdAsync(int id);

        Task<int> CreateAsync(CreateProductionOrderRequest request);

        Task UpdateAsync(UpdateProductionOrderRequest request);

        Task ReleaseAsync(int id);

        Task StartProductionAsync(int id);

        Task CompleteAsync(int id);

        Task DeleteAsync(int id);
    }
}
