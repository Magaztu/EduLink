using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities.States;

public class ReservadoState : SlotState
{
    public override EstadoSlot Nombre => EstadoSlot.Reservado;

    public override void Cancelar(SlotHorario slot)
    {
        slot.CupoActual--;
        slot.EstadoInterno = new DisponibleState();
    }

    // Anda lleno
}