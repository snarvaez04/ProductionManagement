using System.Data;

namespace ProductionManagement.Data.Context
{
    public interface IDbConnectionFactory
    {
        IDbConnection CreateConnection();
    }
}
