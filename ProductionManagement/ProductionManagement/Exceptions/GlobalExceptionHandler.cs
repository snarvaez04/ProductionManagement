using Microsoft.AspNetCore.Diagnostics;

namespace ProductionManagement.Exceptions
{
    public class GlobalExceptionHandler : IExceptionHandler
    {
        public GlobalExceptionHandler()
        {
        }

        public async ValueTask<bool> TryHandleAsync(HttpContext httpContext, Exception exception, CancellationToken cancellationToken)
        {

            httpContext.Response.StatusCode = StatusCodes.Status500InternalServerError;

            await httpContext.Response.WriteAsJsonAsync(
                new
                {
                    message = "An unexpected error occurred."
                },
                cancellationToken);

            return true;
        }
    }
}
