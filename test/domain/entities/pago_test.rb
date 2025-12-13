require "test_helper"
require "minitest/mock"
require_relative "../../../app/domain/entities/pago"
require_relative "../../../app/domain/entities/reserva"
require_relative "../../../app/domain/entities/cliente"
require_relative "../../../app/domain/enums/estado_reserva"

class PagoTest < ActiveSupport::TestCase

  test "un pago se puede aprobar si la reserva está pendiente" do
    # Preparo una reserva falsa (mock) que está pendiente
    reserva_mock = Minitest::Mock.new
    reserva_mock.expect(:estado, Enums::EstadoReserva::PENDIENTE)
    # Espero que al final se llame a 'confirmar' en la reserva
    reserva_mock.expect(:confirmar, nil)
    # El pago necesita el cliente de la reserva para la estrategia
    reserva_mock.expect(:cliente, Entities::Cliente.new(id: "cliente-1"))

    # Preparo una estrategia de pago falsa
    metodo_pago_mock = Minitest::Mock.new
    # Le digo que simule un pago exitoso
    metodo_pago_mock.expect(:procesar, true, [100, "cliente-1"])

    # Creo el pago
    pago = Entities::Pago.new(
      reserva: reserva_mock,
      metodo_pago: metodo_pago_mock,
      monto_total: 100
    )

    # Acción de aprobar
    pago.aprobar

    # Verifico que el estado del pago cambió a 'Aprobado'
    assert_equal "Aprobado", pago.estado
    # Y verifico que se llamó a los métodos esperados en los mocks
    reserva_mock.verify
    metodo_pago_mock.verify
  end

  test "un pago NO se puede aprobar si la reserva ya está confirmada" do
    # Preparo una reserva que ya está confirmada
    reserva_mock = Minitest::Mock.new
    reserva_mock.expect(:estado, Enums::EstadoReserva::CONFIRMADA)

    # Preparo una estrategia de pago (no debería ni llegar a usarse)
    metodo_pago_mock = Minitest::Mock.new

    # Creo el pago
    pago = Entities::Pago.new(
      reserva: reserva_mock,
      metodo_pago: metodo_pago_mock,
      monto_total: 100
    )

    # Verifico que lanza un error al intentar aprobar
    assert_raises StandardError do
      pago.aprobar
    end
  end
end
