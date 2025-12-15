using EduLink.Domain.Enums;

namespace EduLink.Application.DTOs;

public record PublicarServicioRequest(
    Guid ProveedorId,
    string Titulo,
    string Descripcion,
    decimal PrecioBase,
    int DuracionMinutos,
    Modalidad Modalidad,
    string? Ubicacion = null);