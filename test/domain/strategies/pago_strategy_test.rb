require "test_helper"
require_relative "../../../app/domain/strategies/tarjeta_pago_strategy"
require_relative "../../../app/domain/strategies/transferencia_pago_strategy"
require_relative "../../../app/domain/strategies/pagar_en_sitio_strategy"

class PagoStrategyTest < ActiveSupport::TestCase

  test "TarjetaPagoStrategy funciona como se espera" do
    estrategia = Strategies::TarjetaPagoStrategy.new
    
    assert_equal "Tarjeta", estrategia.nombre
    # El método procesar debe devolver true para simular éxito
    assert estrategia.procesar(100, "cliente-id")
  end

  test "TransferenciaPagoStrategy funciona como se espera" do
    estrategia = Strategies::TransferenciaPagoStrategy.new
    
    assert_equal "Transferencia", estrategia.nombre
    assert estrategia.procesar(100, "cliente-id")
  end

  test "PagarEnSitioStrategy funciona como se espera" do
    estrategia = Strategies::PagarEnSitioStrategy.new
    
    assert_equal "PagarEnSitio", estrategia.nombre
    assert estrategia.procesar(100, "cliente-id")
  end
end
