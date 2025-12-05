class ServiciosController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action :set_servicio, only: [:show, :edit, :update]
  before_action :require_provider_owner, only: [:edit, :update]

  def index
    @servicios = Service.all
    if params[:query].present?
      @servicios = @servicios.where("titulo ILIKE ? OR descripcion ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end
    @servicios = @servicios.order(created_at: :desc)
  end

  def show
    @is_provider = current_user && current_user.id == @servicio.user_id

    if @is_provider
      @slots = @servicio.slots.order(:inicio)
    else
      @slots = @servicio.slots
                          .where("inicio > ?", Time.current)
                          .where("cupo_actual < cupo_max")
                          .order(:inicio)
    end
  end

  def new
    @servicio = Service.new
  end

  def create
    unless current_user.is_a?(Provider) #Esto nunca debería pasar igual hhh
      redirect_to servicios_path, alert: "¡Oye! Solo los proveedores pueden publicar servicios."
      return
    end

    create_params = service_params.dup
    if create_params[:porcentaje_cargo].present?
      create_params[:porcentaje_cargo] = create_params[:porcentaje_cargo].to_f / 100.0
    end

    @servicio = current_user.services.new(create_params)

    if @servicio.save
      redirect_to servicio_path(@servicio), notice: '¡Servicio publicado! Ahora ponle horarios.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    update_params = service_params.dup
    if update_params[:porcentaje_cargo].present?
      update_params[:porcentaje_cargo] = update_params[:porcentaje_cargo].to_f / 100.0
    end

    if @servicio.update(update_params)
      redirect_to servicio_path(@servicio), notice: '¡Servicio actualizado!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_servicio
    @servicio = Service.find(params[:id])
  end

  def require_provider_owner
    unless current_user && current_user.id == @servicio.user_id
      redirect_to servicio_path(@servicio), alert: "¡Manos quietas! Este no es tu servicio."
                                                    # Tampocotín debería ocurrir
    end
  end

  def service_params
    # FIX: Removed custom_image
    params.require(:service).permit(:titulo, :descripcion, :precio_base, :duracion_minutos, :modalidad, :ubicacion, :plazo_cancelacion, :porcentaje_cargo, :image_url)
  end
end
