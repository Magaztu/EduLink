using EduLink.Domain.Enums;
using System;

namespace EduLink.Domain.Entities.States;

public abstract class SlotState
{
    public abstract EstadoSlot Nombre { get; }

    public virtual void Reservar(SlotHorario slot) =>
        throw new InvalidOperationException($"No se puede reservar un slot en estado {Nombre}.");

    public virtual void Cancelar(SlotHorario slot) =>
        throw new InvalidOperationException($"No se puede cancelar un slot en estado {Nombre}.");

    public virtual void Expirar(SlotHorario slot) =>
        slot.EstadoInterno = new ExpiradoState();
}