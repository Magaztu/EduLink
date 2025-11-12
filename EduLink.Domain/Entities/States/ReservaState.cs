using System; // Visual estudio añadio esto

namespace EduLink.Domain.Entities.States;

public abstract class ReservaState
{
    public abstract EstadoReserva Nombre { get; }

    public virtual void Cancelar(Reserva reserva, DateTime ahora) =>
        throw new InvalidOperationException($"No se puede cancelar una reserva en estado {Nombre}.");

    public virtual void Completar(Reserva reserva) =>
        throw new InvalidOperationException($"No se puede completar una reserva en estado {Nombre}.");

    public virtual void Confirmar(Reserva reserva) =>
        throw new InvalidOperationException($"No se puede confirmar una reserva en estado {Nombre}.");
}