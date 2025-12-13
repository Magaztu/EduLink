require "test_helper"
require "bigdecimal" # <-- Importante
require_relative "../../../app/domain/strategies/precio_base_strategy"
require_relative "../../../app/domain/strategies/primer_clase_descuento_strategy"
require_relative "../../../app/domain/strategies/impuesto_incluido_strategy"
require_relative "../../../app/domain/entities/cliente"

class PrecioStrategyTest < ActiveSupport::TestCase

  test "PrecioBaseStrategy devuelve el precio base sin cambios" do
    estrategia = Strategies::PrecioBaseStrategy.new
    precio_final = estrategia.calcular(100, nil)
    assert_equal 100, precio_final
  end

  test "PrimerClaseDescuentoStrategy aplica 10% si el cliente es nuevo" do
    estrategia = Strategies::PrimerClaseDescuentoStrategy.new
    cliente_nuevo = Entities::Cliente.new(historial: [])
    precio_final = estrategia.calcular(100, cliente_nuevo)
    assert_equal 90, precio_final
  end

  test "PrimerClaseDescuentoStrategy NO aplica descuento si el cliente ya tiene reservas" do
    estrategia = Strategies::PrimerClaseDescuentoStrategy.new
    cliente_antiguo = Entities::Cliente.new(historial: ["una reserva pasada"])
    precio_final = estrategia.calcular(100, cliente_antiguo)
    assert_equal 100, precio_final
  end

  test "ImpuestoIncluidoStrategy añade el impuesto al precio base" do
    # Estrategia con 15% de impuesto
    estrategia = Strategies::ImpuestoIncluidoStrategy.new("0.15")
    
    # Se usa assert_in_delta para comparar números con decimales de forma segura
    # O podemos comparar directamente con BigDecimal
    precio_final = estrategia.calcular(100, nil)
    assert_equal BigDecimal("115.0"), precio_final
  end
end
