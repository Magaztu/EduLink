require "test_helper"
require_relative "../../../../../app/domain/entities/states/slot/expirado_state"
require_relative "../../../../../app/domain/entities/slot_horario"

class ExpiradoStateTest < ActiveSupport::TestCase

  test "un slot expirado no deja reservar ni cancelar" do
    # 1. Creo el estado expirado
    estado = Entities::States::Slot::ExpiradoState.new
    slot = Entities::SlotHorario.new # Un slot cualquiera

    # 2. Intento reservar y espero que falle
    assert_raises StandardError do
      estado.reservar(slot)
    end

    # 3. Intento cancelar y tambien debe fallar
    assert_raises StandardError do
      estado.cancelar(slot)
    end
    
    # 4. Y obvio, su nombre debe ser Expirado
    assert_equal "Expirado", estado.nombre
  end
end
