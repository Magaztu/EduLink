require_relative './events/reserva_confirmada_event'

class PagarReservaUseCase
  # SOLID: Inyección de dependencias obligatoria.
  def initialize(reserva_repo:, pago_repo:, notificador:)
    @reserva_repo = reserva_repo
    @pago_repo = pago_repo
    @notificador = notificador
  end

  def ejecutar(reserva_id:, metodo_pago:)
    reserva = @reserva_repo.find(reserva_id)
    raise ArgumentError, 'Reserva no encontrada, ¿seguro que era este ID?' unless reserva

    monto = reserva.servicio.calcular_precio_final(reserva.cliente)
    pago = Entities::Pago.new(reserva: reserva, metodo_pago: metodo_pago, monto_total: monto)
    
    pago.aprobar

    @pago_repo.save(pago)
    @reserva_repo.save(reserva)

    evento = Events::ReservaConfirmadaEvent.new(
      reserva_id: reserva.id,
      cliente_nombre: reserva.cliente.nombre,
      cliente_email: reserva.cliente.email,
      servicio_titulo: reserva.servicio.titulo,
      fecha_slot: reserva.slot.inicio
    )

    @notificador.on_next(evento)

    pago.id
  end
end
