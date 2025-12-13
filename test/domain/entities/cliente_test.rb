require "test_helper"
require "minitest/mock"
# Traigo mis clases
require_relative "../../../app/domain/entities/cliente"
require_relative "../../../app/domain/entities/servicio"
require_relative "../../../app/domain/entities/slot_horario"
require_relative "../../../app/domain/entities/reserva"
require_relative "../../../app/domain/enums/estado_slot"

class ClienteTest < ActiveSupport::TestCase

  test "un cliente puede reservar si hay lugar" do
    # Crear al cliente y el servicio
    juan = Entities::Cliente.new(nombre: "Juan")
    clase_guitarra = Entities::Servicio.new(titulo: "Guitarra")

    # Simular un slot libre
    slot_libre = Minitest::Mock.new
    slot_libre.expect(:estado, "Disponible") # Le digo que diga que sí está libre
    slot_libre.expect(:reservar, nil)        # Y que acepte la reserva

    # Juan intenta reservar
    juan.reservar(clase_guitarra, slot_libre)

    # Verificar la reserva en el historial
    assert_equal 1, juan.historial.size
    # y que el tipo de la reserva sea el mismo objeto
    assert_kind_of Entities::Reserva, juan.historial.first
  end

  test "un cliente NO puede reservar si está ocupado" do
    # Creo a mi cliente
    ana = Entities::Cliente.new(nombre: "Ana")
    clase_piano = Entities::Servicio.new(titulo: "Piano")
    
    # Simulo un slot que YA está reservado
    slot_ocupado = Minitest::Mock.new
    slot_ocupado.expect(:estado, "Reservado") # Le digo que diga que NO está libre

    # Ana intenta reservar y espero que falle
    assert_raises StandardError do
      ana.reservar(clase_piano, slot_ocupado)
    end

    # Pobrecita con el historial vacío pipipipiipi
    assert_empty ana.historial
  end
end
