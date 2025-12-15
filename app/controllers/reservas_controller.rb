class ReservasController < ApplicationController
  before_action :require_user
  before_action :require_client_role, only: [:new, :create]

  def new
    @slot = SlotHorario.find(params[:slot_horario_id])
    @servicio = @slot.service
    
    if @servicio.user_id == current_user.id
      redirect_to servicio_path(@servicio), alert: "No puedes reservar tu propio servicio."
    end
  end

  def create
    existing_reservation = Reservation.find_by(
      user_id: current_user.id, 
      slot_horario_id: params[:slot_horario_id],
      estado: 'Pendiente'
    )

    if existing_reservation
      redirect_to new_reserva_pago_path(existing_reservation.id), notice: 'Ya tienes una reserva pendiente para este horario. Por favor, completa el pago.'
      return
    end

    use_case = ReservarServicioUseCase.new(
      cliente_repo: UsuarioRepository.new,
      servicio_repo: ServicioRepository.new,
      reserva_repo: ReservaRepository.new,
      slot_repo: SlotHorarioRepository.new
    )
    
    begin
      nueva_reserva_id = use_case.ejecutar(
        cliente_id: current_user.id,
        servicio_id: params[:service_id],
        slot_id: params[:slot_horario_id]
      )
      redirect_to new_reserva_pago_path(nueva_reserva_id), notice: 'Reserva creada. Por favor, completa el pago.'
    rescue ArgumentError => e
      redirect_to servicio_path(params[:service_id]), alert: e.message
    rescue StandardError => e
      redirect_to servicio_path(params[:service_id]), alert: e.message
    end
  end

  private

  def require_client_role
    if current_user.is_a?(Provider)

      flash[:persistent_warning] = "Los proveedores no pueden reservar servicios. Por favor, crea una cuenta de Cliente para proceder."
      redirect_to servicios_path
    end
  end
end
