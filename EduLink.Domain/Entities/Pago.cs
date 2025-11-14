using EduLink.Domain.Enums;
using EduLink.Domain.Interfaces;
using System;
using System.Threading.Tasks;

namespace EduLink.Domain.Entities;

public class Pago
{
    protected Pago()
    {
        Reserva = null!;
        MetodoPago = null!;
    } //No debería haber problema porque no lo usamos, es para EF

    public Pago(Reserva reserva, IPagoStrategy metodoPago, decimal montoTotal)
    {
        Reserva = reserva;
        MetodoPago = metodoPago;
        MontoTotal = montoTotal;
        Estado = "Pendiente";
    }

    public Guid Id { get; init; } = Guid.NewGuid();
    public Guid ReservaId { get; set; }
    public Reserva Reserva { get; init; }
    public IPagoStrategy MetodoPago { get; set; } // fuera enums buu
    //public IPrecioStrategy PoliticaPrecio { get; set; }
    public string Estado { get; private set; } = "Pendiente";
    //public decimal PrecioBase { get; set; }

    public decimal MontoTotal { get; }

    public async Task AprobarAsync()
    {
        if (Reserva.Estado != EstadoReserva.Pendiente)
            throw new InvalidOperationException("Solo se puede aprobar un pago con reserva pendiente.");

        var exito = await MetodoPago.ProcesarAsync(MontoTotal, Reserva.Cliente.Id);

        Estado = exito ? "Aprobado" : "Fallido";

        if (exito)
        {
            Reserva.Confirmar();
            //notificaciones hacer despues
        }
    }

    public bool PuedeReembolsar()
    {
        return Estado == "Aprobado" &&
               !Reserva.PoliticaCancelacion.PuedeCancelar(Reserva.Slot.Inicio, DateTime.UtcNow);
    }
}