require_relative './slot_state'
require_relative '../../../enums/estado_slot'
require_relative './disponible_state'

module Entities
  module States
    module Slot
      class ReservadoState < SlotState
        def nombre
          Enums::EstadoSlot::RESERVADO
        end

        def cancelar(slot)
          # Si cancelan y estaba lleno, se libera un cupo y vuelve a estar disponible.
          slot.cupo_actual -= 1
          slot.estado_interno = DisponibleState.new
        end

        # Anda lleno, así que no se puede reservar. No hacemos nada.
      end
    end
  end
end
