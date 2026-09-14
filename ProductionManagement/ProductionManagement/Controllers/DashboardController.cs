using Microsoft.AspNetCore.Mvc;
using ProductionManagement.Data.Services;
using ProductionManagement.Shared.DTOs;
using ProductionManagement.Shared.DTOs.DashboardSummary;

namespace ProductionManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public sealed class DashboardController : ControllerBase
    {
        private readonly IDashboardRepository _repository;

        public DashboardController(IDashboardRepository repository)
        {
            _repository = repository;
        }

        [HttpGet("summary")]
        public async Task<ActionResult<DashboardSummaryDto>> GetSummary()
        {
            var result = await _repository.GetSummaryAsync();

            if (result is null)
                return NotFound();

            return Ok(result);
        }

        [HttpGet("recent-activity")]
        public async Task<ActionResult<IEnumerable<DashboardRecentActivityDto>>>
        GetRecentActivity([FromQuery] int top = 10)
        {
            if (top <= 0)
                return BadRequest("The 'top' value must be greater than zero.");

            if (top > 100)
                return BadRequest("The 'top' value cannot exceed 100.");

            var result = await _repository.GetRecentActivityAsync(top);

            return Ok(result);
        }
    }
}
