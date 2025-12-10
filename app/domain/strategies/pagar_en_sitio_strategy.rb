require_relative '../interfaces/i_pago_strategy'

module Strategies
  class PagarEnSitioStrategy
    include Interfaces::IPagoStrategy

    def nombre
      "PagarEnSitio"
    end

    def procesar(monto, cliente_id)
      puts "Pago en efectivo programado para #{monto}. Por favor cumpla no sea ratón."
      true # Se asume que el pago se realizará
    end
  end
end
