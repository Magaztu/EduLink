using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities;

public class SlotHorario
{
    public Guid Id { get; init; } = Guid.NewGuid();
    public DateTime Inicio { get; set; }
    public DateTime Fin { get; set; }
    public int CupoMax { get; set; }
    public int CupoActual { get; private set; } = 0;
    public EstadoSlot Estado { get; private set; } = EstadoSlot.Disponible;

    public void Reservar()
    {
        if (Estado != EstadoSlot.Disponible)
            throw new InvalidOperationException("No se puede reservar un slot no disponible.");

        if (CupoActual >= CupoMax)
            throw new InvalidOperationException("El cupo máximo ha sido alcanzado.");

        CupoActual++;
        if (CupoActual >= CupoMax)
            Estado = EstadoSlot.Reservado;
    }

    public void Cancelar()
    {
        if (CupoActual > 0) CupoActual--;
        Estado = EstadoSlot.Disponible; // o Expirado después nose, aún no hacemos las politicas de ccancelar
    }
}