class PublicarServicioUseCase
  def initialize(proveedor_repo:, servicio_repo:)
    @proveedor_repo = proveedor_repo
    @servicio_repo = servicio_repo
  end

  def ejecutar(proveedor_id:, titulo:, descripcion:, precio_base:, duracion_minutos:, modalidad:, ubicacion: nil, politica_cancelacion:)
    proveedor = @proveedor_repo.find(proveedor_id)
    raise ArgumentError, 'Proveedor no encontrado.' unless proveedor.is_a?(Entities::Proveedor)


    provider_services_count = Service.where(user_id: proveedor.id).count
    if provider_services_count >= AppConfig.limite_servicios_gratuitos
      # L+imite de servicios publicados alcanzado establecido por la tablita de parametrización
      raise StandardError, "Has alcanzado el límite de #{AppConfig.limite_servicios_gratuitos} servicios publicados."
    end

    nuevo_servicio = Entities::Servicio.new(
      titulo: titulo,
      descripcion: descripcion,
      precio_base: precio_base,
      duracion_minutos: duracion_minutos,
      modalidad: modalidad,
      ubicacion: ubicacion
    )

    nuevo_servicio.politica_cancelacion = Entities::PoliticaCancelacion.new(politica_cancelacion)

    proveedor.publicar_servicio(nuevo_servicio)

    @servicio_repo.save(nuevo_servicio)
  end
end
