class AdminController < ApplicationController
  before_action :require_admin

  def index
    @tables = %w[User Service Reservation Payment SlotHorario Inquiry]
    @selected_table = params[:table] || @tables.first
    
    if params[:query].present?
      if @selected_table == "Inquiry"
        @records = Inquiry.where("topic ILIKE ? OR body ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").limit(100)
      else
        @records = @selected_table.constantize.where("id::text ILIKE ?", "%#{params[:query]}%").limit(100)
      end
    else
      @records = @selected_table.constantize.limit(100).order(created_at: :desc)
    end
  end

  private

  def require_admin
    # FIX: Usar el método centralizado del modelo
    unless current_user&.admin?
      redirect_to root_path, alert: "No tienes permiso para acceder a esta sección."
    end
  end
end
