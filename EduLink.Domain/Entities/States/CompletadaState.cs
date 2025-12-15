using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities.States;

public class CompletadaState : ReservaState
{
    public override EstadoReserva Nombre => EstadoReserva.Completada;

    // En estado "Completado", generalmente no se permiten más transiciones

    public override void Cancelar(Reserva reserva, DateTime ahora)
    {
        throw new InvalidOperationException("No se puede cancelar una reserva ya completada.");
    }

    public override void Completar(Reserva reserva)
    {
        // Ya está completada ea
    }

    public override void Confirmar(Reserva reserva)
    {
        // Ya fue confirmada antes de completarse ujum
    }
}