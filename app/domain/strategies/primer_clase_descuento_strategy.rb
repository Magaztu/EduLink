require_relative '../interfaces/i_precio_strategy'

module Strategies
  class PrimerClaseDescuentoStrategy
    include Interfaces::IPrecioStrategy

    def calcular(precio_base, cliente)
      # 10% de descuento si es la primera reserva del cliente
      cliente.historial.empty? ? precio_base * 0.90 : precio_base
    end
  end
end
