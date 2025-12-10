module Interfaces
  module IPagoStrategy
    def nombre
      # IDE puso estomm
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def procesar(monto, cliente_id)
      # Simular transacción porq no se usó ningun servicio externo
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end
