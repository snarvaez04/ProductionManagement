using System.Data;
using Microsoft.Data.SqlClient;

namespace ProductionManagement.Data.Context
{
    public class DbContext : IDbContext
    {
        private readonly string _connectionString;

        public DbContext(string connectionString)
        {
            if (!string.IsNullOrWhiteSpace(connectionString))
                _connectionString = connectionString;
            else
                throw new InvalidOperationException("Connection string not found or is invalid.");
        }

        public IDbConnection CreateConnection()
            => new SqlConnection(_connectionString);
    }
}






public interface IDbContext
{
    IDbConnection CreateConnection();
}


