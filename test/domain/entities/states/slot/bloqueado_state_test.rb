require "test_helper"
require_relative "../../../../../app/domain/entities/states/slot/bloqueado_state"
require_relative "../../../../../app/domain/entities/slot_horario"

class BloqueadoStateTest < ActiveSupport::TestCase

  test "un slot bloqueado no deja reservar" do
    estado = Entities::States::Slot::BloqueadoState.new
    slot = Entities::SlotHorario.new

    assert_raises StandardError do
      estado.reservar(slot)
    end
  end

  test "un slot bloqueado se puede desbloquear" do
    estado = Entities::States::Slot::BloqueadoState.new
    slot = Entities::SlotHorario.new
    slot.estado_interno = estado # Le asigno el estado bloqueado

    # Acción: lo desbloqueo
    estado.desbloquear(slot)

    # Verificación: ahora debe ser un estado Disponible
    assert_kind_of Entities::States::Slot::DisponibleState, slot.estado_interno
  end
end
