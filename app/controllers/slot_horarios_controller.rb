class SlotHorariosController < ApplicationController
  before_action :require_user
  before_action :set_service, only: [:create]
  before_action :require_provider_owner, only: [:create, :destroy]

  def create
    slot_repo = SlotHorarioRepository.new
    servicio_repo = ServicioRepository.new
    use_case = AnadirHorarioUseCase.new(slot_repo: slot_repo, servicio_repo: servicio_repo)
    
    begin
      use_case.ejecutar(
        servicio_id: @service.id,
        proveedor_id: current_user.id,
        atributos_slot: slot_params.to_h.symbolize_keys
      )
      redirect_to servicio_path(@service), notice: 'Horario añadido con éxito.'
    rescue StandardError => e
      redirect_to servicio_path(@service), alert: "No se pudo añadir el horario: #{e.message}"
    end
  end

  def destroy

    use_case = EliminarHorarioUseCase.new(
      slot_repo: SlotHorarioRepository.new,
      reserva_repo: ReservaRepository.new
    )
    
    begin
      use_case.ejecutar(slot_id: params[:id], proveedor_id: current_user.id)

      service = Service.find(SlotHorario.find(params[:id]).service_id) rescue nil
      redirect_to servicio_path(service || servicios_path), notice: 'Horario eliminado. Las reservas asociadas han sido canceladas.'
    rescue ActiveRecord::RecordNotFound

      redirect_to servicios_path, notice: 'El horario ya ha sido eliminado.'
    rescue StandardError => e
      service = Service.find(SlotHorario.find(params[:id]).service_id) rescue nil
      redirect_to servicio_path(service || servicios_path), alert: "No se pudo eliminar el horario: #{e.message}"
    end
  end

  private

  def set_service
    @service = Service.find(params[:servicio_id])
  end

  def require_provider_owner

    if action_name == 'destroy'
      slot = SlotHorario.find(params[:id])
      service = slot.service
    else
      service = @service
    end
    
    unless current_user.id == service.user_id
      redirect_to servicio_path(service), alert: "No tienes permiso para gestionar horarios de este servicio."
    end
  end

  def slot_params
    params.require(:slot_horario).permit(:inicio, :fin, :cupo_max)
  end
end
