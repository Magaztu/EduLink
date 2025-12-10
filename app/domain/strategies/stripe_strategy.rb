require_relative '../interfaces/i_pago_strategy'

module Strategies
  class StripeStrategy
    include Interfaces::IPagoStrategy

    def nombre
      'Stripe'
    end

    def procesar(monto, cliente_id)
      # Implementar stripe peeero ninguno tiene cuenta asi q uugfufu
      puts "Procesando $#{monto} para cliente #{cliente_id} via Stripe..."
      # Simlar pago correcto
      true
    end
  end
end
