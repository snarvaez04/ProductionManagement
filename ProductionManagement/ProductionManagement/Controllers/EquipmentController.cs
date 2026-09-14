using Microsoft.AspNetCore.Mvc;
using ProductionManagement.Data.Services;
using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public sealed class EquipmentController : ControllerBase
    {
        private readonly IEquipmentRepository _repository;

        public EquipmentController(IEquipmentRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<EquipmentListDto>>> GetList()
        {
            var result = await _repository.GetListAsync();
            return Ok(result);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<EquipmentDetailsDto>> GetById(int id)
        {
            var result = await _repository.GetByIdAsync(id);

            if (result is null)
                return NotFound();

            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult<int>> Create(CreateEquipmentRequest request)
        {
            var id = await _repository.CreateAsync(request);

            return CreatedAtAction(
                nameof(GetById),
                new { id },
                id);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, UpdateEquipmentRequest request)
        {
            var updatedRequest = new UpdateEquipmentRequest
            {
                Name = request.Name,
                EquipmentType = request.EquipmentType,
                Location = request.Location
            };

            await _repository.UpdateAsync(id, updatedRequest);

            return NoContent();
        }

        [HttpPost("{id:int}/operational")]
        public async Task<IActionResult> SetOperational(int id)
        {
            await _repository.SetOperationalAsync(id);

            return NoContent();
        }

        [HttpPost("{id:int}/maintenance")]
        public async Task<IActionResult> SetMaintenance(int id)
        {
            await _repository.SetMaintenanceAsync(id);

            return NoContent();
        }

        [HttpPost("{id:int}/down")]
        public async Task<IActionResult> SetDown(int id)
        {
            await _repository.SetDownAsync(id);

            return NoContent();
        }

        [HttpPost("{id:int}/offline")]
        public async Task<IActionResult> SetOffline(int id)
        {
            await _repository.SetOfflineAsync(id);

            return NoContent();
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _repository.DeleteAsync(id);

            return NoContent();
        }
    }

}
