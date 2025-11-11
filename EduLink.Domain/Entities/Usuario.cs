namespace EduLink.Domain.Entities;

public abstract class Usuario
{
    public Guid Id { get; init; } // Identificador único globalin
    public string Nombre { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
}