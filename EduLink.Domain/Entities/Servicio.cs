using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities;

public class Servicio
{
    public Guid Id { get; init; } = Guid.NewGuid();
    public Guid ProveedorId { get; set; }
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public decimal PrecioBase { get; set; }
    public int DuracionMinutos { get; set; }
    public Modalidad Modalidad { get; set; }
    public string? Ubicacion { get; set; } // null si es online
    public List<SlotHorario> Slots { get; private set; } = new();
}