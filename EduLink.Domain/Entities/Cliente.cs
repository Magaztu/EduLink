using EduLink.Domain.Enums;
using EduLink.Domain.Interfaces;

namespace EduLink.Domain.Entities;

public class Cliente : Usuario, IPuedeReservar
{
    public List<Reserva> Historial { get; private set; } = new();
    public List<string> MetodosPagoTokenizados { get; private set; } = new();

    public void Reservar(Servicio servicio, SlotHorario slot)
    {
        if (slot.Estado != EstadoSlot.Disponible)
            throw new InvalidOperationException("El slot no está disponible.");

        var nuevaReserva = new Reserva(this, servicio, slot);
        Historial.Add(nuevaReserva);
        // Notificación se disparará luego con Observer, creo
    }
}