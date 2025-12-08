require_relative './slot_state'
require_relative '../../../enums/estado_slot'
require_relative './reservado_state'
require_relative './bloqueado_state'
require_relative './expirado_state'

module Entities
  module States
    module Slot
      class DisponibleState < SlotState
        def nombre
          Enums::EstadoSlot::DISPONIBLE
        end

        def reservar(slot)
          # Le sumamos uno al cupo
          slot.cupo_actual += 1
          
          # Si con esta reserva ya se llenó, cambiamos el estado.
          if slot.cupo_actual >= slot.cupo_max
            slot.estado_interno = ReservadoState.new
          end
        end

        def cancelar(slot)
          # Si alguien cancela, liberamos un cupo.
          slot.cupo_actual -= 1 if slot.cupo_actual > 0
        end

        def bloquear(slot)
          # El proveedor lo bloquea, así que cambiamos el estado.
          slot.estado_interno = BloqueadoState.new
        end

        def expirar(slot)
          # Si ya pasó la fecha, pues expiró.
          slot.estado_interno = ExpiradoState.new
        end
      end
    end
  end
end
