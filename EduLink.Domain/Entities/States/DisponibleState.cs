using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities.States;

public class DisponibleState : SlotState
{
    public override EstadoSlot Nombre => EstadoSlot.Disponible;

    public override void Reservar(SlotHorario slot)
    {
        if (slot.CupoActual >= slot.CupoMax)
        {
            slot.EstadoInterno = new ReservadoState();
        }
        else
        {
            slot.CupoActual++;
            // Sigue disponible si hay cupo
        }
    }

    public override void Cancelar(SlotHorario slot)
    {
        if (slot.CupoActual > 0) slot.CupoActual--;
        // Sigue disponible
    }
}