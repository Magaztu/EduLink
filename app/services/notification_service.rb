class NotificationService
  def on_next(event)
    case event
    when Events::ReservaConfirmadaEvent
      puts "--- Notificación de Reserva Confirmada ---"
      puts "Enviando email a #{event.cliente_email}..."
      puts "Reserva: #{event.reserva_id}"
      puts "Servicio: #{event.servicio_titulo}"
      puts "Fecha: #{event.fecha_slot}"
      puts "----------------------------------------"
      # El impresor del correo jij jaja iji ja a
    end
  end
end
