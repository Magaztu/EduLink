require_relative '../interfaces/i_pago_strategy'

module Strategies
  class TransferenciaPagoStrategy
    include Interfaces::IPagoStrategy

    def nombre
      "Transferencia"
    end

    def procesar(monto, cliente_id)
      puts "Procesando transferencia por #{monto}..."
      true # Simula un pago exitoso
    end
  end
end
