namespace EduLink.Application.DTOs;

public record ReservarServicioRequest(
    Guid ClienteId,
    Guid ServicioId,
    Guid SlotId);