using Microsoft.Data.SqlClient;

var connectionString = "Server=localhost\\SQLEXPRESS;Database=EduLinkDb;Trusted_Connection=true;TrustServerCertificate=true;";
using var connection = new SqlConnection(connectionString);
try
{
    connection.Open();
    Console.WriteLine("Conexión a SQL Server exitosa.");
    Console.WriteLine("Versión del servidor: " + connection.ServerVersion);
}
catch (Exception ex)
{
    Console.WriteLine("Error de conexión: " + ex.Message);
}