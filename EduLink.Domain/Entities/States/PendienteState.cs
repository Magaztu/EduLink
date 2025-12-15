using EduLink.Domain.Enums;
using System;

namespace EduLink.Domain.Entities.States;

public class PendienteState : ReservaState
{
	public override EstadoReserva Nombre => EstadoReserva.Pendiente; // Aquí se usa el enum pero no es necesario

	public override void Cancelar(Reserva reserva, DateTime ahora)
	{
		if (!reserva.PoliticaCancelacion.PuedeCancelar(reserva.Slot.Inicio, ahora))
			throw new InvalidOperationException("Cancelación fuera de plazo. Aplica cargo.");

		reserva.EstadoInterno = new CanceladaState();
		reserva.Slot.Cancelar();
	}

	public override void Confirmar(Reserva reserva)
	{
		reserva.EstadoInterno = new ConfirmadaState();
	}
}