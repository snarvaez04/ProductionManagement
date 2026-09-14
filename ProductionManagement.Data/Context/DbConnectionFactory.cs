using System.Data;
using Microsoft.Data.SqlClient;

namespace ProductionManagement.Data.Context
{
    public class DbConnectionFactory : IDbConnectionFactory
    {
        private readonly string _connectionString;

        public DbConnectionFactory(string connectionString)
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