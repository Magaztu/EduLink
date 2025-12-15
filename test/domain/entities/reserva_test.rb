require "test_helper"
require "minitest/mock"
# Traemos nuestras clases
require_relative "../../../app/domain/entities/reserva"
require_relative "../../../app/domain/entities/cliente"
require_relative "../../../app/domain/entities/servicio"
require_relative "../../../app/domain/entities/slot_horario"
require_relative "../../../app/domain/enums/estado_reserva"

class ReservaTest < ActiveSupport::TestCase

  test "cuando creo una reserva, debe estar pendiente" do
    # Preparo mis datos
    cliente = Entities::Cliente.new(nombre: "Pepe")
    servicio = Entities::Servicio.new(titulo: "Clase de Batería")
    
    # Uso un mock simple para el slot porque la reserva lo usa al crearse
    slot = Minitest::Mock.new
    slot.expect(:reservar, nil) # La reserva le va a decir "reservate"

    # Hago la acción
    mi_reserva = Entities::Reserva.new(cliente, servicio, slot)
    
    # Compruebo que esté pendiente
    assert_equal "Pendiente", mi_reserva.estado
  end

  test "si confirmo la reserva, cambia a confirmada" do
    # Preparo todo igual que antes
    cliente = Entities::Cliente.new(nombre: "Pepe")
    servicio = Entities::Servicio.new(titulo: "Clase de Batería")
    slot = Minitest::Mock.new
    slot.expect(:reservar, nil)

    mi_reserva = Entities::Reserva.new(cliente, servicio, slot)
    
    # Acción: Confirmar
    mi_reserva.confirmar
    
    # Verificación
    assert_equal "Confirmada", mi_reserva.estado
  end

  test "puedo cancelar si estoy a tiempo" do
    cliente = Entities::Cliente.new(nombre: "Pepe")
    servicio = Entities::Servicio.new(titulo: "Clase de Batería")
    
    # El slot necesita tener una fecha para que la política la revise
    slot = Minitest::Mock.new
    slot.expect(:reservar, nil)
    slot.expect(:inicio, Time.now + 5.days) # Falta mucho, así que sí se puede
    slot.expect(:cancelar, nil) # Al final, el slot debe liberarse

    mi_reserva = Entities::Reserva.new(cliente, servicio, slot)

    # Acción: Cancelar ahora mismo
    mi_reserva.cancelar(Time.now)

    # Verificación
    assert_equal "Cancelada", mi_reserva.estado
  end

  test "NO puedo cancelar si es muy tarde" do
    cliente = Entities::Cliente.new(nombre: "Pepe")
    servicio = Entities::Servicio.new(titulo: "Clase de Batería")
    
    # El slot es casi ya mismo, no debería dejarme cancelar
    slot = Minitest::Mock.new
    slot.expect(:reservar, nil)
    slot.expect(:inicio, Time.now + 1.hour) # Solo falta 1 hora!

    mi_reserva = Entities::Reserva.new(cliente, servicio, slot)

    # Intento cancelar y espero que falle
    assert_raises StandardError do
      mi_reserva.cancelar(Time.now)
    end
    
    # La reserva debe seguir pendiente porque falló la cancelación
    assert_equal "Pendiente", mi_reserva.estado
  end
end
