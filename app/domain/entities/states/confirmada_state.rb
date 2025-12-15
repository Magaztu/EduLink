require_relative './reserva_state'
require_relative '../../enums/estado_reserva' # Corrected path
require_relative './cancelada_state'
require_relative './completada_state'

module Entities
  module States
    class ConfirmadaState < ReservaState
      def nombre
        Enums::EstadoReserva::CONFIRMADA
      end

      def cancelar(reserva, ahora)
        unless reserva.politica_cancelacion.puede_cancelar(reserva.slot.inicio, ahora)
          raise StandardError, 'Cancelación fuera de plazo. Aplica cargo.'
        end

        reserva.estado_interno = CanceladaState.new
        reserva.slot.cancelar
      end

      def completar(reserva)
        reserva.estado_interno = CompletadaState.new
      end
    end
  end
end
