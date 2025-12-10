require 'bigdecimal'
require_relative '../interfaces/i_precio_strategy'

module Strategies
  class ImpuestoIncluidoStrategy
    include Interfaces::IPrecioStrategy

    def initialize(tasa_impuesto = 0.12)
      # Usa AppConfig o el defecto pasado en el constructor
      tasa = tasa_impuesto || AppConfig.tasa_impuesto
      @tasa_impuesto = BigDecimal(tasa.to_s)
    end

    def calcular(precio_base, cliente)
      BigDecimal(precio_base.to_s) * (1 + @tasa_impuesto)
    end
  end
end
