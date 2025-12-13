require "test_helper"
# Traigo todas las clases reales que voy a usar
require_relative "../../app/domain/entities/cliente"
require_relative "../../app/domain/entities/proveedor"
require_relative "../../app/domain/entities/servicio"
require_relative "../../app/domain/entities/slot_horario"
require_relative "../../app/domain/entities/reserva"
require_relative "../../app/domain/entities/politica_cancelacion"

class ReservaIntegrationTest < ActiveSupport::TestCase

  test "un cliente puede reservar un slot de un servicio publicado por un proveedor" do
    # Preparación, esta prueba unitaria no usa mcoks
    # Creo un proveedor real
    proveedor = Entities::Proveedor.new(id: "prov-1", nombre: "Guitarras Paco")

    # Creo un servicio real
    servicio = Entities::Servicio.new(
      id: "serv-1",
      titulo: "Clase de Rock",
      precio_base: 50
    )

    # El proveedor publica el servicio+
    proveedor.publicar_servicio(servicio)

    # Creo un slot real y lo añado al servicio
    slot = Entities::SlotHorario.new(
      id: "slot-1",
      inicio: Time.now + 1.day,
      fin: Time.now + 1.day + 1.hour,
      cupo_max: 1
    )
    servicio.slots << slot

    # Creo un cliente real
    cliente = Entities::Cliente.new(id: "cli-1", nombre: "Juan Rockero")

    # Actuando ando
    # El cliente reserva el slot del servicio
    cliente.reservar(servicio, slot)

    # Assert a los rsultados
    # Reviso que la reserva se creó en el historial del cliente
    assert_equal 1, cliente.historial.size
    reserva_creada = cliente.historial.first

    # Reviso que los datos de la reserva sean correctos
    assert_equal "Pendiente", reserva_creada.estado
    assert_equal cliente, reserva_creada.cliente
    assert_equal servicio, reserva_creada.servicio

    # Reviso que el estado del slot haya cambiado
    assert_equal "Reservado", slot.estado
    assert_equal 1, slot.cupo_actual
  end
end
