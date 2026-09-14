using Microsoft.AspNetCore.Mvc;
using ProductionManagement.Data.Services;
using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public sealed class ProductionEventsController : ControllerBase
    {
        private readonly IProductionEventRepository _repository;

        public ProductionEventsController(IProductionEventRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductionEventListDto>>> GetList()
        {
            var result = await _repository.GetListAsync();

            return Ok(result);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<ProductionEventDto>> GetById(int id)
        {
            var result = await _repository.GetByIdAsync(id);

            if (result is null)
                return NotFound();

            return Ok(result);
        }

        [HttpGet("coil/{coilId:int}")]
        public async Task<ActionResult<IEnumerable<ProductionEventDto>>> GetByCoil(int coilId)
        {
            var result = await _repository.GetByCoilAsync(coilId);

            return Ok(result);
        }

        [HttpGet("equipment/{equipmentId:int}")]
        public async Task<ActionResult<IEnumerable<ProductionEventDto>>> GetByEquipment(int equipmentId)
        {
            var result = await _repository.GetByEquipmentAsync(equipmentId);

            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult<int>> Create(CreateProductionEventRequest request)
        {
            var id = await _repository.CreateAsync(request);

            return CreatedAtAction(nameof(GetById), new { id }, id);
        }
    }

}
