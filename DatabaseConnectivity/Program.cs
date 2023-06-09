﻿using System.Data;
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
            GetById(1);
            UpdateById(5, "Konoha");
            DeleteById(5);
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
    }

    /* Transactional command wrapper
    so that the transaction functionality can be reused */
    // Returning row affected
    private static int WithTx(Func<SqlCommand, SqlCommand> command)
    {
        _sqlConnection = new(_connectionString);

        _sqlConnection.Open();

        var sqlTransaction = _sqlConnection.BeginTransaction();

        int rowAffected = 0;
        try
        {
            SqlCommand sqlCommand = new();

            var cmd = command(sqlCommand); // here is the main command, where the 'command' parameter passed

            /* connection & transaction assignment after calling the callback 'command' function
            so that the callback function cannot messed up with the connection & transaction */
            cmd.Connection = _sqlConnection;
            cmd.Transaction = sqlTransaction;

            rowAffected = cmd.ExecuteNonQuery();

            sqlTransaction.Commit();
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

        return rowAffected;
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
        try
        {
            var rowAffected = WithTx(command =>
            {
                command.CommandText = "INSERT INTO region (name) VALUES (@name)";
                command.Parameters.Add(new SqlParameter
                {
                    ParameterName = "@name",
                    Value = name,
                    SqlDbType = SqlDbType.VarChar
                });

                return command;
            });

            Console.WriteLine(rowAffected > 0 ? "Region successfully added!" : "Failed to add region!");
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
    }

    // GetByIdRegion (command)
    public static void GetById(int id)
    {
        _sqlConnection = new(_connectionString);

        _sqlConnection.Open();

        try
        {
            SqlCommand sqlCommand = new()
            {
                Connection = _sqlConnection,
                CommandText = "SELECT * FROM region WHERE id = @id",
            };

            SqlParameter sqlParameter = new()
            {
                ParameterName = "@id",
                Value = id,
                SqlDbType = SqlDbType.Int
            };

            sqlCommand.Parameters.Add(sqlParameter);

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
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
    }

    // UpdateByIdRegion (transaction)
    public static void UpdateById(int id, string name)
    {
        try
        {
            var rowAffected = WithTx(command =>
            {
                command.CommandText = "UPDATE region SET name = @name WHERE id = @id";
                command.Parameters.AddRange(new[]
                {
                    new SqlParameter
                    {
                        ParameterName = "@name",
                        Value = name,
                        SqlDbType = SqlDbType.VarChar
                    },
                    new SqlParameter
                    {
                        ParameterName = "@id",
                        Value = id,
                        SqlDbType = SqlDbType.Int
                    }
                });

                return command;
            });

            Console.WriteLine(rowAffected > 0 ? "Region successfully updated!" : "Failed to update region!");
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
    }

    // DeleteByIdRegion (transaction)
    public static void DeleteById(int id)
    {
        try
        {
            var rowAffected = WithTx(command =>
            {
                command.CommandText = "DELETE FROM region WHERE id=@id";
                command.Parameters.Add(new SqlParameter
                {
                    ParameterName = "@id",
                    Value = id,
                    SqlDbType = SqlDbType.Int
                });

                return command;
            });

            Console.WriteLine(rowAffected > 0 ? "Region successfully deleted!" : "Failed to delete region!");
        }
        catch (Exception e)
        {
            Console.WriteLine(e.Message);
        }
    }
}