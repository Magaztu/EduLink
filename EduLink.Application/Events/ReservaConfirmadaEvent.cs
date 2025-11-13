using EduLink.Domain.Entities;

namespace EduLink.Application.Events;

public record ReservaConfirmadaEvent(
    Guid ReservaId,
    string ClienteNombre,
    string ClienteEmail,
    string ServicioTitulo,
    DateTime FechaSlot
);