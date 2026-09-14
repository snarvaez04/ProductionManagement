using Microsoft.AspNetCore.Mvc;
using ProductionManagement.Data.Services;
using ProductionManagement.Shared.DTOs;

namespace ProductionManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public sealed class ProductionOrdersController : ControllerBase
    {
        private readonly IProductionOrderRepository _repository;

        public ProductionOrdersController(IProductionOrderRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductionOrderListDto>>> GetList()
        {
            var result = await _repository.GetListAsync();
            return Ok(result);
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<ProductionOrderDetailsDto>> GetById(int id)
        {
            var result = await _repository.GetByIdAsync(id);

            if (result is null)
                return NotFound();

            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult<int>> Create(CreateProductionOrderRequest request)
        {
            var id = await _repository.CreateAsync(request);

            return CreatedAtAction(
                nameof(GetById),
                new { id },
                id);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, UpdateProductionOrderRequest request)
        {
            var updatedRequest = new UpdateProductionOrderRequest
            {
                CustomerName = request.CustomerName,
                ProductCode = request.ProductCode,
                SteelGrade = request.SteelGrade,
                TargetWidth = request.TargetWidth,
                TargetThickness = request.TargetThickness,
                TargetWeight = request.TargetWeight,
                Quantity = request.Quantity,
                DueDate = request.DueDate
            };

            await _repository.UpdateAsync(id, updatedRequest);

            return NoContent();
        }

        [HttpPost("{id:int}/release")]
        public async Task<IActionResult> Release(int id)
        {
            await _repository.ReleaseAsync(id);
            return NoContent();
        }

        [HttpPost("{id:int}/start")]
        public async Task<IActionResult> StartProduction(int id)
        {
            await _repository.StartProductionAsync(id);
            return NoContent();
        }

        [HttpPost("{id:int}/complete")]
        public async Task<IActionResult> Complete(int id)
        {
            await _repository.CompleteAsync(id);
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
