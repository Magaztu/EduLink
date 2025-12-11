require_relative '../domain/entities/servicio'

class ServicioRepository
  def find(id)
    service_record = Service.find(id)
    map_to_domain_entity(service_record)
  end

  def save(domain_servicio)
    service_record = map_to_ar_model(domain_servicio)
    service_record.save!
    map_to_domain_entity(service_record)
  end

  private

  def map_to_domain_entity(service_record)
    return nil unless service_record
    Entities::Servicio.new(
      id: service_record.id,
      proveedor_id: service_record.user_id,
      titulo: service_record.titulo,
      descripcion: service_record.descripcion,
      precio_base: service_record.precio_base,
      duracion_minutos: service_record.duracion_minutos,
      modalidad: service_record.modalidad,
      ubicacion: service_record.ubicacion,
      politica_cancelacion: Entities::PoliticaCancelacion.new(
        plazo_maximo_cancelacion_horas: service_record.plazo_cancelacion,
        porcentaje_cargo: service_record.porcentaje_cargo
      )
    )
  end

  def map_to_ar_model(domain_servicio)
    ar_model = Service.find_or_initialize_by(id: domain_servicio.id)
    ar_model.user_id = domain_servicio.proveedor_id
    ar_model.titulo = domain_servicio.titulo
    ar_model.descripcion = domain_servicio.descripcion
    ar_model.precio_base = domain_servicio.precio_base
    ar_model.duracion_minutos = domain_servicio.duracion_minutos
    ar_model.modalidad = domain_servicio.modalidad
    ar_model.ubicacion = domain_servicio.ubicacion

    if domain_servicio.politica_cancelacion
      ar_model.plazo_cancelacion = domain_servicio.politica_cancelacion.plazo_maximo_cancelacion_horas
      ar_model.porcentaje_cargo = domain_servicio.politica_cancelacion.porcentaje_cargo
    end
    ar_model
  end
end
