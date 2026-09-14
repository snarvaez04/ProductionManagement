using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Data.Services
{
    public interface IEquipmentRepository
    {
        Task<IEnumerable<EquipmentListDto>> GetListAsync();

        Task<EquipmentDetailsDto?> GetByIdAsync(int id);

        Task<int> CreateAsync(CreateEquipmentRequest request);

        Task UpdateAsync(UpdateEquipmentRequest request);

        Task SetOperationalAsync(int id);

        Task SetMaintenanceAsync(int id);

        Task SetDownAsync(int id);

        Task SetOfflineAsync(int id);

        Task DeleteAsync(int id);
    }
}
