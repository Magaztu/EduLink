require "test_helper"
require_relative "../../../app/domain/entities/cliente"
require_relative "../../../app/domain/entities/servicio"
require_relative "../../../app/domain/entities/slot_horario"
require_relative "../../../app/domain/enums/estado_slot"
require_relative "../../../app/domain/entities/states/slot/disponible_state"

class ClienteTest < ActiveSupport::TestCase
  def setup
    @cliente = Entities::Cliente.new(nombre: "Juan Test", email: "juan@test.com")
    @servicio = Entities::Servicio.new(titulo: "Clase de prueba")
  end

  test "un cliente puede reservar un slot disponible" do
    slot_disponible = Entities::SlotHorario.new(estado_interno: Entities::States::Slot::DisponibleState.new)
    
    @cliente.reservar(@servicio, slot_disponible)
    
    assert_equal 1, @cliente.historial.length
    assert_kind_of Entities::Reserva, @cliente.historial.first
  end

  test "el historial de un cliente nuevo está vacío" do
    cliente_nuevo = Entities::Cliente.new
    assert_empty cliente_nuevo.historial
  end

  test "reservar añade una reserva al historial del cliente" do
    slot = Entities::SlotHorario.new
    
    assert_difference('@cliente.historial.count', 1) do
      @cliente.reservar(@servicio, slot)
    end
  end
end
