require "test_helper"
require "minitest/mock"
require_relative "../../app/services/reservar_servicio_use_case"
require_relative "../../app/domain/entities/cliente"
require_relative "../../app/domain/entities/servicio"
require_relative "../../app/domain/entities/slot_horario"
require_relative "../../app/domain/enums/estado_slot"

class ReservarServicioUseCaseTest < ActiveSupport::TestCase

  test "el caso de uso puede reservar un servicio exitosamente" do
    # Prepar los datos falsos que supuestamente vienen de la BD
    cliente_falso = Entities::Cliente.new(id: "cliente-123", nombre: "Pepe")
    servicio_falso = Entities::Servicio.new(id: "servicio-abc")
    
    # Le pongo fecha futura al slot para que no falle la validación de expirado
    slot_falso = Entities::SlotHorario.new(
      id: "slot-xyz", 
      cupo_max: 1,
      inicio: Time.now + 1.day # Mañana, así que no ha expirado
    )

    # Preparo los repositorios falsos (Mocks). Son como templates vacíos
    repo_cliente_mock = Minitest::Mock.new
    repo_servicio_mock = Minitest::Mock.new
    repo_slot_mock = Minitest::Mock.new
    repo_reserva_mock = Minitest::Mock.new

    # Les doy su guion, o sea qué deben hacer cuando los llamen
    repo_cliente_mock.expect(:find, cliente_falso, ["cliente-123"])
    repo_servicio_mock.expect(:find, servicio_falso, ["servicio-abc"])
    repo_slot_mock.expect(:find, slot_falso, ["slot-xyz"])
    # Espero que al final me pidan que guarde una Reserva o cualquier reserva
    repo_reserva_mock.expect(:save, true) { |arg| arg.is_a?(Entities::Reserva) }
    # Y que también guarden el Slot (para q se actualice el cupo)
    repo_slot_mock.expect(:save, true) { |arg| arg.is_a?(Entities::SlotHorario) }

    # Crear el caso de uso, pero con los repositorios de mentira
    use_case = ReservarServicioUseCase.new(
      cliente_repo: repo_cliente_mock,
      servicio_repo: repo_servicio_mock,
      slot_repo: repo_slot_mock,
      reserva_repo: repo_reserva_mock
    )

    # Ejecutar la acción que quiero probar
    id_reserva_creada = use_case.ejecutar(
      cliente_id: "cliente-123",
      servicio_id: "servicio-abc",
      slot_id: "slot-xyz"
    )

    # Verificar que los dobles de acción hicieron su trabajo como les dije
    repo_cliente_mock.verify
    repo_servicio_mock.verify
    repo_slot_mock.verify
    repo_reserva_mock.verify
    
    # Y una comprobación extra para que el test no se queje de que está vacío
    assert_not_nil id_reserva_creada, "El caso de uso debería devolver un ID de reserva?"
  end
end
