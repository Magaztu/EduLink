class ReservarServicioUseCase
  # SOLID: Inyección de dependencias obligatoria.
  def initialize(cliente_repo:, servicio_repo:, reserva_repo:, slot_repo:)
    @cliente_repo = cliente_repo
    @servicio_repo = servicio_repo
    @reserva_repo = reserva_repo
    @slot_repo = slot_repo
  end

  def ejecutar(cliente_id:, servicio_id:, slot_id:)
    cliente = @cliente_repo.find(cliente_id)
    raise ArgumentError, 'Cliente no encontrado, ¿estás seguro que existe?' unless cliente.is_a?(Entities::Cliente)

    servicio = @servicio_repo.find(servicio_id)
    raise ArgumentError, 'Servicio no encontrado.' unless servicio

    slot = @slot_repo.find(slot_id)
    raise ArgumentError, 'Slot no encontrado, parece que ya no existe.' unless slot

    if slot.inicio < Time.current
      slot.expirar
      @slot_repo.save(slot)
      raise StandardError, "Este horario ya pasó, no se puede reservar."
    end

    if slot.estado == 'Reservado' && slot.cupo_actual < slot.cupo_max
      puts "DEBUG: Fixing inconsistent slot state. Was Reservado but has space."
      slot.estado_interno = Entities::States::Slot::DisponibleState.new
    end

    slot.reservar
    
    # 0 lógica, sólo llamar a los dominios y sus metodosmsmsm
    cliente.reservar(servicio, slot)

    ultima_reserva = cliente.historial.last
    @reserva_repo.save(ultima_reserva)
    @slot_repo.save(slot)

    ultima_reserva.id
  end
end
