using Microsoft.AspNetCore.Mvc;
using ProductionManagement.Data.Services;
using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public sealed class CoilsController : ControllerBase
    {
        private readonly ICoilRepository _repository;

        public CoilsController(ICoilRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CoilListDto>>> GetList()
        {
            var result = await _repository.GetListAsync();
            return Ok(result);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<CoilDetailsDto>> GetById(int id)
        {
            var result = await _repository.GetByIdAsync(id);

            if (result is null)
                return NotFound();

            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult<int>> Create(CreateCoilRequest request)
        {
            var id = await _repository.CreateAsync(request);

            return CreatedAtAction(
                nameof(GetById),
                new { id },
                id);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, UpdateCoilRequest request)
        {
            var updatedRequest = new UpdateCoilRequest
            {
                Weight = request.Weight,
                Width = request.Width,
                Thickness = request.Thickness,
                CurrentLocation = request.CurrentLocation
            };

            await _repository.UpdateAsync(id, updatedRequest);

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
