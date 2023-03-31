using System.Data;
using System.Data.SqlClient;

public class Program
{
    private static string _dbUser = "sa"; // specify mssql user
    private static string _dbPassword = "@DTS2023"; // specify mssql password
    private static string _dbName = "db_hr_dts"; // specify mssql db

    static string _connectionString =
        $"Data Source=localhost,1433;User={_dbUser};Password={_dbPassword};Database={_dbName};Connect Timeout=30;";

    static SqlConnection _sqlConnection;

    public static void Main(string[] args)
    {
        try
        {
            InsertRegion("Wakanda");
            GetAllRegion();
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
    }

    // GetAllRegion (command)
    public static void GetAllRegion()
    {
        _sqlConnection = new(_connectionString);
        
        _sqlConnection.Open();

        SqlCommand sqlCommand = new()
        {
            Connection = _sqlConnection,
            CommandText = "SELECT * FROM region"
        };

        using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
        {
            if (sqlDataReader.HasRows)
            {
                while (sqlDataReader.Read())
                {
                    Console.WriteLine("====================");
                    Console.WriteLine($"Id : {sqlDataReader[0]}");
                    Console.WriteLine($"Name : {sqlDataReader[1]}");
                    Console.WriteLine("====================");
                }
            }
            else
            {
                Console.WriteLine("Data not found!");
            }

            sqlDataReader.Close();
            _sqlConnection.Close();
        }
    }

    // InsertRegion (transaction)
    public static void InsertRegion(string name)
    {
        _sqlConnection = new(_connectionString);
        
        _sqlConnection.Open();

        var sqlTransaction = _sqlConnection.BeginTransaction();
        try
        {
            SqlCommand sqlCommand = new()
            {
                Connection = _sqlConnection,
                CommandText = "INSERT INTO region (name) VALUES (@name)",
                Transaction = sqlTransaction
            };

            SqlParameter sqlParameter = new()
            {
                ParameterName = "@name",
                Value = name,
                SqlDbType = SqlDbType.VarChar
            };

            sqlCommand.Parameters.Add(sqlParameter);

            var rowAffected = sqlCommand.ExecuteNonQuery();
            
            sqlTransaction.Commit();

            if (rowAffected > 0)
            {
                Console.WriteLine("Region successfully added!");
            }
            else
            {
                Console.WriteLine("Failed to add region!");
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);

            try
            {
                sqlTransaction.Rollback();
            }
            catch (Exception r)
            {
                Console.WriteLine(r.Message);
            }
        }
    }

    // TODO : GetById Region (command)
    // TODO : Update Region (transaction)
    // TODO : Delete Region (transaction)
}