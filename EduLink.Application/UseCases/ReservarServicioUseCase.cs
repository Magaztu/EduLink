using EduLink.Application.DTOs;
using EduLink.Application.Interfaces;
using EduLink.Domain.Entities;
using EduLink.Domain.Enums;

namespace EduLink.Application.UseCases;

public class ReservarServicioUseCase
{
    private readonly IClienteRepository _clienteRepo;
    private readonly IServicioRepository _servicioRepo;
    private readonly IReservaRepository _reservaRepo;

    public ReservarServicioUseCase(
        IClienteRepository clienteRepo,
        IServicioRepository servicioRepo,
        IReservaRepository reservaRepo)
    {
        _clienteRepo = clienteRepo;
        _servicioRepo = servicioRepo;
        _reservaRepo = reservaRepo;
    }

    public async Task EjecutarAsync(ReservarServicioRequest request)
    {
        var cliente = await _clienteRepo.ObtenerPorIdAsync(request.ClienteId);
        if (cliente == null)
            throw new ArgumentException("Cliente no encontrado.");

        var servicio = await _servicioRepo.ObtenerConSlotsAsync(request.ServicioId);
        if (servicio == null)
            throw new ArgumentException("Servicio no encontrado.");

        var slot = servicio.Slots.FirstOrDefault(s => s.Id == request.SlotId);
        if (slot == null || slot.Estado != EstadoSlot.Disponible)
            throw new ArgumentException("Slot no disponible.");

        cliente.Reservar(servicio, slot);

        var ultimaReserva = cliente.Historial.Last();
        await _reservaRepo.GuardarAsync(ultimaReserva);

        // ya no va aki el observe r r r
    }
}