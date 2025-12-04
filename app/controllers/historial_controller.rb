class HistorialController < ApplicationController
  before_action :require_user

  def index
    if current_user.is_a?(Client)

      @reservas = current_user.reservations.includes(slot_horario: :service).order(created_at: :desc)
      @is_provider = false
    elsif current_user.is_a?(Provider)

      @servicios = current_user.services.order(created_at: :desc)
      @is_provider = true
    end
  end
end
