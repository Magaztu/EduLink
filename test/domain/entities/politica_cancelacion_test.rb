require "test_helper"
require_relative "../../../app/domain/entities/politica_cancelacion"

class PoliticaCancelacionTest < ActiveSupport::TestCase

  test "permite cancelar si falta mucho tiempo" do
    # Preparo la política (se puede cancelar hasta 24 horas antes)
    politica = Entities::PoliticaCancelacion.new(
      plazo_maximo_cancelacion_horas: 24,
      porcentaje_cargo: 0.10
    )
    
    # Simulo las fechas
    inicio_del_slot = Time.now + 48.hours # El evento es en 2 días
    ahora = Time.now

    # Verifico que el método me diga que sí puedo
    assert politica.puede_cancelar(inicio_del_slot, ahora)
  end

  test "NO permite cancelar si falta poco tiempo" do
    # Misma política de 24 horas
    politica = Entities::PoliticaCancelacion.new(
      plazo_maximo_cancelacion_horas: 24,
      porcentaje_cargo: 0.10
    )
    
    # Simulo las fechas
    inicio_del_slot = Time.now + 10.hours # El evento es en 10 horas!!!
    ahora = Time.now

    # Verifico que el método me diga que NO puedo
    refute politica.puede_cancelar(inicio_del_slot, ahora)
  end

  test "calcula el cargo correctamente" do
    # Política con un cargo del 25%
    politica = Entities::PoliticaCancelacion.new(
      plazo_maximo_cancelacion_horas: 24,
      porcentaje_cargo: 0.25
    )
    
    monto_total = 100.0

    # Verifico que el cálculo sea correcto (25% de 100 es 25)
    assert_equal 25.0, politica.calcular_cargo(monto_total)
  end
end
