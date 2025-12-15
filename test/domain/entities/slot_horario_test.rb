require "test_helper"
require_relative "../../../app/domain/entities/slot_horario"
require_relative "../../../app/domain/enums/estado_slot"

class SlotHorarioTest < ActiveSupport::TestCase

  test "un slot nuevo nace disponible y con cupo cero" do
    slot = Entities::SlotHorario.new(cupo_max: 5)
    
    assert_equal "Disponible", slot.estado
    assert_equal 0, slot.cupo_actual
  end

  test "reservar un slot aumenta su cupo actual" do
    slot = Entities::SlotHorario.new(cupo_max: 5)
    
    slot.reservar
    
    assert_equal 1, slot.cupo_actual
    assert_equal "Disponible", slot.estado # Sigue disponible porque 1 < 5
  end

  test "el slot cambia a RESERVADO cuando se llena" do
    # Creo un slot con capacidad para 1 sola persona
    slot = Entities::SlotHorario.new(cupo_max: 1)
    
    # Reservo el único lugar
    slot.reservar
    
    assert_equal 1, slot.cupo_actual
    assert_equal "Reservado", slot.estado # Ahora debe estar lleno
  end

  test "cancelar una reserva libera cupo" do
    # Iniciar cno un slot lleno
    slot = Entities::SlotHorario.new(cupo_max: 1)
    slot.reservar 
    
    # Ahora cancelo
    slot.cancelar
    
    assert_equal 0, slot.cupo_actual
    assert_equal "Disponible", slot.estado # Vuelve a estar disponible
  end
end
