using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities;

public class Reserva
{
    public Guid Id { get; init; } = Guid.NewGuid();
    public Cliente Cliente { get; init; }
    public Servicio Servicio { get; init; }
    public SlotHorario Slot { get; init; }
    public EstadoReserva Estado { get; private set; } = EstadoReserva.Pendiente; // Set privadin, nita métoodo
    public PoliticaCancelacion PoliticaCancelacion { get; init; }

    public Pago? PagoAsociado { get; set; }

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

    public void Cancelar(DateTime ahora)
    {
        
        if (!PoliticaCancelacion.PuedeCancelar(Slot.Inicio, ahora))
        {

            throw new InvalidOperationException("Cancelación fuera de plazo. Aplica cargo.");
        }

        Estado = EstadoReserva.Cancelada;
        Slot.Cancelar();
    }

    public void Completar()
    {
        if (Estado != EstadoReserva.Confirmada)
            throw new InvalidOperationException("Solo se puede completar una reserva confirmada.");

        Estado = EstadoReserva.Completada;
    }

    public void Confirmar()
    {
        if (Estado != EstadoReserva.Pendiente)
            throw new InvalidOperationException("Solo se puede confirmar una reserva pendiente.");

        Estado = EstadoReserva.Confirmada;
    }
}