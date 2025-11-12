using EduLink.Domain.Entities;

namespace EduLink.Application.Events;

public record ReservaConfirmadaEvent(
    Guid ReservaId,
    Cliente Cliente,
    Servicio Servicio,
    DateTime FechaSlot);