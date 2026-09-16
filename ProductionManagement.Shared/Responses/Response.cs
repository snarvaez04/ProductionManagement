
namespace ProductionManagement.Shared.Responses
{
    public record Response<T>
    {
        public bool IsSuccess { get; init; }

        public T? Data { get; init; }

        public string? Message { get; init; }

        public List<string>? Errors { get; init; }

        public static Response<T> Success(T data, string? message = null, object? metadata = null) =>
            new() { IsSuccess = true, Data = data, Message = message };

        // Factory method for structural/business rule failures
        public static Response<T> Failure(string errorMessage, List<string>? errors = null) =>
            new() { IsSuccess = false, Data = default, Message = errorMessage, Errors = errors };
    }

}
