require_relative '../interfaces/i_precio_strategy'

module Strategies
  class PrecioBaseStrategy
    include Interfaces::IPrecioStrategy

    def calcular(precio_base, cliente)
      precio_base
    end
  end
end
