class CancelacionesController < ApplicationController
  before_action :require_user

  def create
    reserva = Reservation.find(params[:reserva_id])

    if reserva.user_id != current_user.id
      redirect_to historial_path, alert: "No puedes cancelar una reserva que no es tuya."
      return
    end

    use_case = CancelarReservaUseCase.new
    begin
      use_case.ejecutar(reserva_id: reserva.id)
      redirect_to historial_path, notice: "Reserva cancelada con éxito."
    rescue StandardError => e
      redirect_to historial_path, alert: "No se pudo cancelar la reserva: #{e.message}"
    end
  end
end
