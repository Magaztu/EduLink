require_relative '../domain/entities/reserva'

class ReservaRepository
  def find(id)
    reservation_record = Reservation.find(id)
    map_to_domain_entity(reservation_record)
  end

  def save(domain_reserva)
    reservation_record = map_to_ar_model(domain_reserva)
    reservation_record.save!
    map_to_domain_entity(reservation_record)
  end

  private

  def map_to_domain_entity(record)
    return nil unless record

    cliente = UsuarioRepository.new.find(record.user_id)
    slot = SlotHorarioRepository.new.find(record.slot_horario_id)
    
    ar_slot = ::SlotHorario.find(record.slot_horario_id)
    servicio = ServicioRepository.new.find(ar_slot.service_id)

    Entities::Reserva.new(cliente, servicio, slot).tap do |domain_entity|
      domain_entity.id = record.id
      state_class = "Entities::States::#{record.estado}State".constantize
      domain_entity.estado_interno = state_class.new
      domain_entity.politica_cancelacion = Entities::PoliticaCancelacion.new(
        plazo_maximo_cancelacion_horas: record.plazo_maximo_cancelacion_horas,
        porcentaje_cargo: record.porcentaje_cargo
      )
    end
  end

  def map_to_ar_model(domain_entity)
    ar_model = Reservation.find_or_initialize_by(id: domain_entity.id)
    ar_model.user_id = domain_entity.cliente.id
    ar_model.slot_horario_id = domain_entity.slot.id
    ar_model.estado = domain_entity.estado

    ar_model.plazo_maximo_cancelacion_horas = domain_entity.politica_cancelacion.plazo_maximo_cancelacion_horas
    ar_model.porcentaje_cargo = domain_entity.politica_cancelacion.porcentaje_cargo
    ar_model
  end
end
