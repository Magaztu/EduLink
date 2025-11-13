using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities.States;

public class ExpiradoState : SlotState
{
    public override EstadoSlot Nombre => EstadoSlot.Expirado;
    // Si se pasa de la fecha tampoco puede reservar
}