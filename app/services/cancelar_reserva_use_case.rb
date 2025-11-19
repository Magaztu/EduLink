class CancelarReservaUseCase
  def initialize(reserva_repo: ReservaRepository.new, slot_repo: SlotHorarioRepository.new)
    @reserva_repo = reserva_repo
    @slot_repo = slot_repo
  end

  def ejecutar(reserva_id:)
    reserva = @reserva_repo.find(reserva_id)
    
    puts "DEBUG: Cancelando reserva #{reserva.id}. Estado slot antes: #{reserva.slot.estado}, Cupo: #{reserva.slot.cupo_actual}"

    #Llamar al dominio ou llea
    reserva.cancelar(Time.current)
    
    puts "DEBUG: Cancelada. Estado slot despues: #{reserva.slot.estado}, Cupo: #{reserva.slot.cupo_actual}"

    @reserva_repo.save(reserva)
    @slot_repo.save(reserva.slot)
    
    puts "DEBUG: Slot guardado."
  end
end
