require_relative './slot_state'
require_relative '../../../enums/estado_slot'
require_relative './disponible_state'

module Entities
  module States
    module Slot
      class BloqueadoState < SlotState
        def nombre
          Enums::EstadoSlot::BLOQUEADO
        end
        
        # No permite reservar ni cancelar si el proveedor tiene motivos. Punto sin retorno

        # Puede reactivarse por un admin. Vuelve a estar disponible.
        def desbloquear(slot)
          slot.estado_interno = DisponibleState.new
        end
      end
    end
  end
end
