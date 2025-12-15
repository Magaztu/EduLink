require_relative '../interfaces/i_pago_strategy'

module Strategies
  class TarjetaPagoStrategy
    include Interfaces::IPagoStrategy

    def nombre
      "Tarjeta"
    end

    def procesar(monto, cliente_id)
      puts "Procesando pago con tarjeta por un monto de #{monto}..."
      # En una app real, aquí iría la lógica para conectar con un banco
      true # Simula un pago exitoso
    end
  end
end
