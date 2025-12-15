using EduLink.Domain.Enums;

namespace EduLink.Domain.Entities.States;

public class BloqueadoState : SlotState
{
	public override EstadoSlot Nombre => EstadoSlot.Bloqueado;
	// No permite reservar ni cancelar si el proveedor tiene motivos
}