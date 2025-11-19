class AdminController < ApplicationController
  before_action :require_admin

  def index
    @tables = %w[User Service Reservation Payment SlotHorario]
    @selected_table = params[:table] || @tables.first

    if params[:query].present?
      @records = @selected_table.constantize.where("id::text ILIKE ?", "%#{params[:query]}%").limit(100)
    else
      @records = @selected_table.constantize.limit(100).order(created_at: :desc)
    end
  end

  private

  def require_admin
    unless current_user&.email == "admin@prrones.com"
      redirect_to root_path, alert: "No tienes permiso para acceder a esta sección."
    end
  end
end
