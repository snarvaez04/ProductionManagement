using Microsoft.AspNetCore.Mvc;
using ProductionManagement.Data.Services;
using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public sealed class QualityInspectionsController : ControllerBase
    {
        private readonly IQualityInspectionRepository _repository;

        public QualityInspectionsController(IQualityInspectionRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<QualityInspectionListDto>>> GetList()
        {
            var result = await _repository.GetListAsync();

            return Ok(result);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<QualityInspectionDetailsDto>> GetById(int id)
        {
            var result = await _repository.GetByIdAsync(id);

            if (result is null)
                return NotFound();

            return Ok(result);
        }

        [HttpGet("coil/{coilId:int}")]
        public async Task<ActionResult<IEnumerable<QualityInspectionDetailsDto>>> GetByCoil(int coilId)
        {
            var result = await _repository.GetByCoilAsync(coilId);

            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult<int>> Create(CreateQualityInspectionRequest request)
        {
            var id = await _repository.CreateAsync(request);

            return CreatedAtAction(nameof(GetById), new { id }, id);
        }
    }

}
