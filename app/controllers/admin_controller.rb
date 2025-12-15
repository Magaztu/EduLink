class AdminController < ApplicationController
  before_action :require_admin

  def index
    # FIX: Added Inquiry to the list of tables
    @tables = %w[User Service Reservation Payment SlotHorario Inquiry]
    @selected_table = params[:table] || @tables.first
    
    # Basic search functionality
    if params[:query].present?
      # For Inquiry, we might want to search by topic or body as well
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
    unless current_user&.email == "admin@prrones.com"
      redirect_to root_path, alert: "No tienes permiso para acceder a esta sección."
    end
  end
end
