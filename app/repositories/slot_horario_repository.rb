require_relative '../domain/entities/slot_horario'

class SlotHorarioRepository
  def find(id)
    slot_record = ::SlotHorario.find(id)
    map_to_domain_entity(slot_record)
  end

  def save(domain_slot, service_id: nil)
    ar_model = map_to_ar_model(domain_slot)
    ar_model.service_id = service_id if service_id

    puts "DEBUG: Guardando slot #{ar_model.id} con estado: #{ar_model.estado}, cupo: #{ar_model.cupo_actual}"
    
    ar_model.save!
    map_to_domain_entity(ar_model)
  end

  private

  def map_to_domain_entity(slot_record)
    return nil unless slot_record
    domain_entity = Entities::SlotHorario.new(
      id: slot_record.id,
      service_id: slot_record.service_id,
      inicio: slot_record.inicio,
      fin: slot_record.fin,
      cupo_max: slot_record.cupo_max,
      cupo_actual: slot_record.cupo_actual
    )
    state_class_name = "Entities::States::Slot::#{slot_record.estado}State"
    domain_entity.estado_interno = state_class_name.constantize.new
    domain_entity
  end

  def map_to_ar_model(domain_slot)
    ar_model = ::SlotHorario.find_or_initialize_by(id: domain_slot.id)
    ar_model.inicio = domain_slot.inicio
    ar_model.fin = domain_slot.fin
    ar_model.cupo_max = domain_slot.cupo_max
    ar_model.cupo_actual = domain_slot.cupo_actual
    ar_model.estado = domain_slot.estado 
    ar_model
  end
end
