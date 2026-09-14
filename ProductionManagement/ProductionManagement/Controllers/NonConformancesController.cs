using Microsoft.AspNetCore.Mvc;
using ProductionManagement.Data.Services;
using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public sealed class NonConformancesController : ControllerBase
    {
        private readonly INonConformanceRepository _repository;

        public NonConformancesController(INonConformanceRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<NonConformanceListDto>>> GetList()
        {
            var result = await _repository.GetListAsync();

            return Ok(result);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<NonConformanceDetailsDto>> GetById(int id)
        {
            var result = await _repository.GetByIdAsync(id);

            if (result is null)
                return NotFound();

            return Ok(result);
        }

        [HttpGet("coil/{coilId:int}")]
        public async Task<ActionResult<IEnumerable<NonConformanceListDto>>> GetByCoil(int coilId)
        {
            var result = await _repository.GetByCoilAsync(coilId);

            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult<int>> Create(CreateNonConformanceRequest request)
        {
            var id = await _repository.CreateAsync(request);

            return CreatedAtAction(
                nameof(GetById),
                new { id },
                id);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, UpdateNonConformanceRequest request)
        {
            await _repository.UpdateAsync(id, request);

            return NoContent();
        }
    }
}
