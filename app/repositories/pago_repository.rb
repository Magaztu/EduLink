require_relative '../domain/entities/pago'

class PagoRepository
  def find(id)
    payment_record = Payment.find(id)
    map_to_domain_entity(payment_record)
  end

  def save(domain_pago)
    payment_record = map_to_ar_model(domain_pago)
    payment_record.save!
    map_to_domain_entity(payment_record)
  end

  private

  def map_to_domain_entity(record)
    return nil unless record
    
    reserva = ReservaRepository.new.find(record.reservation_id)
    
    Entities::Pago.new(
      id: record.id,
      reserva: reserva,
      monto_total: record.monto_total,
      estado: record.estado
    )
  end

  def map_to_ar_model(domain_entity)
    ar_model = Payment.find_or_initialize_by(id: domain_entity.id)
    ar_model.reservation_id = domain_entity.reserva.id
    ar_model.estado = domain_entity.estado
    ar_model.monto_total = domain_entity.monto_total
    ar_model.metodo_pago = domain_entity.metodo_pago.nombre
    ar_model
  end
end
