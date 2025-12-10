require_relative '../interfaces/i_precio_strategy'

module Strategies
  class CodigoPromocionalStrategy
    include Interfaces::IPrecioStrategy

    def initialize(codigo_esperado: "EDULINK10", descuento_porcentual: 0.10, descuento_fijo: 0)
      @codigo_esperado = codigo_esperado
      @descuento_porcentual = descuento_porcentual
      @descuento_fijo = descuento_fijo
    end

    def calcular(precio_base, cliente)
      # Al final no creo que pongamos un formulario para codigos
      codigo_activo = "EDULINK10" # Simulación

      if codigo_activo == @codigo_esperado
        descuento = precio_base * @descuento_porcentual
        descuento = [@descuento_fijo, descuento].min if @descuento_fijo > 0
        [0, precio_base - descuento].max
      else
        precio_base
      end
    end
  end
end
