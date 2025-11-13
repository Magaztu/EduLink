using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities.States;

public class CanceladaState : ReservaState
{
    public override EstadoReserva Nombre => EstadoReserva.Cancelada;
    // No permitimos transaccíones ( o sea que los metodos por defautl de reservastate no se modifican)
}