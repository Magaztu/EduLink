require_relative './reserva_state'
require_relative '../../enums/estado_reserva' # Corrected path

module Entities
  module States
    class CanceladaState < ReservaState
      def nombre
        Enums::EstadoReserva::CANCELADA
      end
      # No permitimos modificaciones, punto muerto
    end
  end
end
