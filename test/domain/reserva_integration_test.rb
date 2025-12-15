require "test_helper"
require_relative "../../app/domain/entities/cliente"
require_relative "../../app/domain/entities/proveedor"
require_relative "../../app/domain/entities/servicio"
require_relative "../../app/domain/entities/slot_horario"
require_relative "../../app/domain/enums/modalidad"
require_relative "../../app/domain/enums/estado_slot"

class ReservaIntegrationTest < ActiveSupport::TestCase
  def setup
    @cliente = Entities::Cliente.new(nombre: "Juan Cliente", email: "juan@cliente.com")
    @proveedor = Entities::Proveedor.new(nombre: "Profe Carlos", email: "carlos@profe.com")
    
    @servicio = Entities::Servicio.new(
      titulo: "Clase de Guitarra",
      descripcion: "Aprende a tocar la guitarra desde cero.",
      precio_base: 50,
      duracion_minutos: 60,
      modalidad: Enums::Modalidad::PRESENCIAL,
      proveedor_id: @proveedor.id
    )
  end

  test "un cliente puede reservar un slot disponible y el estado del slot cambia" do

    slot = Entities::SlotHorario.new(
      inicio: Time.now + 1.day,
      fin: Time.now + 1.day + 1.hour,
      cupo_max: 1 
    )
    
    assert_equal Enums::EstadoSlot::DISPONIBLE, slot.estado, "El slot debería estar disponible inicialmente"
    assert_equal 0, slot.cupo_actual

    # Acción de reservar
    @cliente.reservar(@servicio, slot)
    slot.reservar

    # Verificaciones
    assert_equal 1, @cliente.historial.count, "El cliente debería tener 1 reserva en su historial"
    assert_equal 1, slot.cupo_actual, "El cupo del slot debería ser 1"
    assert_equal Enums::EstadoSlot::RESERVADO, slot.estado, "El estado del slot debería cambiar a Reservado"
  end

  test "un cliente no puede reservar un slot que ya está reservado" do
    slot = Entities::SlotHorario.new(
      inicio: Time.now + 2.days,
      fin: Time.now + 2.days + 1.hour,
      cupo_max: 1
    )
    
    # Se reserva el slot una vez
    @cliente.reservar(@servicio, slot)
    slot.reservar

    # Verificar que se lanza un error al intentar reservar de nuevo
    assert_raises StandardError do
      slot.reservar
    end
  end
end
