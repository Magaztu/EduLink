using EduLink.Domain.Enums;
using System;

namespace EduLink.Domain.Entities.States;

public class ConfirmadaState : ReservaState
{
    public override EstadoReserva Nombre => EstadoReserva.Confirmada;

    public override void Cancelar(Reserva reserva, DateTime ahora)
    {
        if (!reserva.PoliticaCancelacion.PuedeCancelar(reserva.Slot.Inicio, ahora))
            throw new InvalidOperationException("Cancelación fuera de plazo. Aplica cargo.");

        reserva.EstadoInterno = new CanceladaState();
        reserva.Slot.Cancelar();
    }

    public override void Completar(Reserva reserva)
    {
        reserva.EstadoInterno = new CompletadaState();
    }
}