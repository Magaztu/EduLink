require_relative '../../../enums/estado_slot'

module Entities
  module States
    module Slot
      class SlotState
        # Como esta es la interfaz padre, se definen todos los casos que serán heredados
        # aquellos que no sean sobreescritos quedarán con estos raise, que es lo normal en el patron State
        def nombre
          raise NotImplementedError, "Cada estado debe tener un nombresito."
        end

        def reservar(slot)
          raise StandardError, "No se puede reservar un slot que está #{nombre}."
        end

        def cancelar(slot)
          raise StandardError, "No se puede cancelar un slot que está #{nombre}."
        end

        def expirar(slot)
          raise StandardError, "Pero si ya está #{nombre}, no puede expirar."
        end

        def bloquear(slot)
          raise StandardError, "No puedes bloquear un slot que está #{nombre}."
        end

        def desbloquear(slot)
          raise StandardError, "Si está #{nombre}, no tiene por qué ser bloqueado"
        end
      end
    end
  end
end
