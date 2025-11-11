using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities;

public class Pago
{
    public Guid Id { get; init; } = Guid.NewGuid();
    public Reserva Reserva { get; init; }
    public MetodoPago Metodo { get; set; }
    public string Estado { get; private set; } = "Pendiente";
    public decimal MontoTotal { get; set; }

    public Pago(Reserva reserva, MetodoPago metodo, decimal montoTotal)
    {
        Reserva = reserva;
        Metodo = metodo;
        MontoTotal = montoTotal;
    }

    public void Aprobar()
    {
        if (Reserva.Estado != EstadoReserva.Pendiente)
            throw new InvalidOperationException("No se puede aprobar un pago sin reserva pendiente.");

        Estado = "Aprobado";
        Reserva.Confirmar();
    }

    public bool PuedeReembolsar()
    {
        return Estado == "Aprobado" && 
               Reserva.PoliticaCancelacion.PuedeCancelar(
                   Reserva.Slot.Inicio, 
                   DateTime.UtcNow
               ) == false;
        // Si no puede cancelar sin cargo, se permite reembolso parcial
    }
}