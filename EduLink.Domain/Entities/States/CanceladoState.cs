using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities.States;

public class CanceladoState : SlotState
{
    public override EstadoSlot Nombre => EstadoSlot.Cancelado;
    // Final no se puede reactivar desde aquí (requere acción explícita del proveedor)
}