using EduLink.Application.Events;
using EduLink.Application.Interfaces;
using EduLink.Domain.Entities;
using EduLink.Domain.Interfaces;
using EduLink.Domain.Strategies;

namespace EduLink.Application.UseCases;

public class PagarReservaUseCase
{
    private readonly IReservaRepository _reservaRepo;
    private readonly IPagoRepository _pagoRepo;
    private readonly IDomainObserver<ReservaConfirmadaEvent> _notificador;

    public PagarReservaUseCase(
        IReservaRepository reservaRepo,
        IPagoRepository pagoRepo,
        IDomainObserver<ReservaConfirmadaEvent> notificador)
    {
        _reservaRepo = reservaRepo;
        _pagoRepo = pagoRepo;
        _notificador = notificador;
    }

    public async Task EjecutarAsync(Guid reservaId, IPagoStrategy metodoPago)
    {
        var reserva = await _reservaRepo.ObtenerPorIdAsync(reservaId);
        if (reserva == null)
            throw new ArgumentException("Reserva no encontrada.");

        var monto = reserva.Servicio.CalcularPrecioFinal(reserva.Cliente);
        var pago = new Pago(reserva, metodoPago, monto);
        await pago.AprobarAsync(); // Esto llama a reserva.Confirmar() mm

        await _pagoRepo.GuardarAsync(pago);

        // Confirmal y publical
        var evento = new ReservaConfirmadaEvent(
            ReservaId: reserva.Id,
            ClienteNombre: reserva.Cliente.Nombre,
            ClienteEmail: reserva.Cliente.Email,
            ServicioTitulo: reserva.Servicio.Titulo,
            FechaSlot: reserva.Slot.Inicio
        );

        _notificador.OnNext(evento);
    }
}