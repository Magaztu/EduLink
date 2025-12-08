require_relative './reserva_state'
require_relative '../../enums/estado_reserva' # Corrected path
require_relative './cancelada_state'
require_relative './confirmada_state'

module Entities
  module States
    class PendienteState < ReservaState
      def nombre
        Enums::EstadoReserva::PENDIENTE
      end

      def cancelar(reserva, ahora)
        # Lanza una excepción si la política de cancelación no permite la cancelación.
        unless reserva.politica_cancelacion.puede_cancelar(reserva.slot.inicio, ahora)
          raise StandardError, 'Cancelación fuera de plazo. Aplica cargo.'
        end

        reserva.estado_interno = CanceladaState.new
        reserva.slot.cancelar
      end

      def confirmar(reserva)
        reserva.estado_interno = ConfirmadaState.new
      end
    end
  end
end
