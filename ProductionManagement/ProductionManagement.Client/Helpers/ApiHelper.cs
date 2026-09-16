using System.Net;

namespace ProductionManagement.Client.Helpers
{
    public class ApiHelper
    {
        public static async Task EnsureSuccessAsync(HttpResponseMessage response)
        {
            if (response.IsSuccessStatusCode)
                return;

            if (response.StatusCode == HttpStatusCode.InternalServerError)
            {
                throw new Exception("An unexpected error occurred.");
            }

            throw new Exception("The request could not be completed.");
        }
    }
}
