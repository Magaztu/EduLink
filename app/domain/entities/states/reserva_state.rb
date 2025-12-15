module Entities
  module States
    class ReservaState
      def nombre
        # El IDE añadió esto por default
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def cancelar(reserva, ahora)
        raise StandardError, "No se puede cancelar una reserva en estado #{nombre}."
      end

      def completar(reserva)
        raise StandardError, "No se puede completar una reserva en estado #{nombre}."
      end

      def confirmar(reserva)
        raise StandardError, "No se puede confirmar una reserva en estado #{nombre}."
      end
    end
  end
end
