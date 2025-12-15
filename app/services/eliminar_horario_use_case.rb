class EliminarHorarioUseCase
  def initialize(slot_repo:, reserva_repo:)
    @slot_repo = slot_repo
    @reserva_repo = reserva_repo
  end

  def ejecutar(slot_id:, proveedor_id:)
    slot = @slot_repo.find(slot_id)
    servicio = ServicioRepository.new.find(slot.service_id)

    raise StandardError, "No tienes permiso para eliminar este horario." unless servicio.proveedor_id == proveedor_id

    active_reservations = Reservation.where(slot_horario_id: slot.id).where.not(estado: 'Cancelada')

    active_reservations.each do |res_record|

      reserva = @reserva_repo.find(res_record.id)

      reserva.cancelar(Time.current)
      @reserva_repo.save(reserva)
    end

    ::SlotHorario.find(slot.id).destroy
  end
end
