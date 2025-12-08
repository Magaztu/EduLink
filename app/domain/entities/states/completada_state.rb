require_relative './reserva_state'
require_relative '../../enums/estado_reserva' # Corrected path

module Entities
  module States
    class CompletadaState < ReservaState
      def nombre
        Enums::EstadoReserva::COMPLETADA
      end

      # En estado "Completado", generalmente no se permiten más transiciones

      def cancelar(reserva, ahora)
        raise StandardError, 'No se puede cancelar una reserva ya completada.'
      end

      def completar(reserva)
        # Ya está completada ea
      end

      def confirmar(reserva)
        # Ya fue confirmada antes de completarse ujum
      end
    end
  end
end
