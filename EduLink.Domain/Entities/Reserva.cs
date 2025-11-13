using EduLink.Domain.Entities.States;
using EduLink.Domain.Enums;
using System;

namespace EduLink.Domain.Entities;

public class Reserva
{
    public Guid Id { get; init; } = Guid.NewGuid();
    public Cliente Cliente { get; init; }
    public Servicio Servicio { get; init; }
    public SlotHorario Slot { get; init; }
    public PoliticaCancelacion PoliticaCancelacion { get; init; }
    public Pago? PagoAsociado { get; set; }

    public EstadoReserva Estado => EstadoInterno.Nombre;

    internal ReservaState EstadoInterno { get; set; } = new PendienteState();

    public Reserva(Cliente cliente, Servicio servicio, SlotHorario slot)
    {
        Cliente = cliente;
        Servicio = servicio;
        Slot = slot;
        PoliticaCancelacion = new PoliticaCancelacion
        {
            PlazoMaximoCancelacionHoras = 24,
            PorcentajeCargo = 0.10m
        };

        Slot.Reservar();
    }

    public void Cancelar(DateTime ahora) => EstadoInterno.Cancelar(this, ahora);
    public void Completar() => EstadoInterno.Completar(this);
    public void Confirmar() => EstadoInterno.Confirmar(this);
}