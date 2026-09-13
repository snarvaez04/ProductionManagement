using DbUp;
using System.Reflection;

namespace ProductionManagement.Data.Extensions
{
    public static class DatabaseMigrator
    {
        public static void Migrate(string connectionString)
        {
            EnsureDatabase.For.SqlDatabase(connectionString);

            var upgrader = DeployChanges.To
                .SqlDatabase(connectionString)
                .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly())
                .LogToConsole()
                .Build();

            if (upgrader.IsUpgradeRequired())
            {
                var result = upgrader.PerformUpgrade();

                if (!result.Successful)
                {
                    throw new Exception($"Database upgrade failed: {result.Error}");
                }
            }
        }
    }
}
