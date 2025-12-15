require_relative './slot_state'
require_relative '../../../enums/estado_slot'

module Entities
  module States
    module Slot
      class ExpiradoState < SlotState
        def nombre
          Enums::EstadoSlot::EXPIRADO
        end
        # Si se pasa de la fecha, ya no se puede hacer nada con este slot.
        # No se puede reservar, ni cancelar, ni bloquear. Murió. F.
      end
    end
  end
end
