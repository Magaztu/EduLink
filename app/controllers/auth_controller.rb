class AuthController < ApplicationController
  layout 'auth'

  def login
    if params[:return_to].present?
      session[:return_to] = params[:return_to]
      flash.now[:warning] = "Para continuar con tu reserva, por favor inicia sesión o crea una cuenta."
    end
  end

  def register
  end

  def create_user
    user_class = params[:user][:type].constantize
    @user = user_class.new(user_params)

    if @user.save
      redirect_to login_path, notice: "¡Cuenta creada! Ahora, por favor, inicia sesión."
    else
      flash.now[:alert] = "Uups, algo salió mal. Revisa los errores."
      render :register, status: :unprocessable_entity
    end
  end

  def create_session
    user = User.find_by(email: params[:user][:email])
    if user&.authenticate(params[:user][:password])
      session[:user_id] = user.id
      
      redirect_to(session.delete(:return_to) || servicios_path, notice: "¡Bienvenido de vuelta!")
    else
      flash.now[:alert] = "Correo o contraseña incorrectos, ¡inténtalo de nuevo!"
      render :login, status: :unprocessable_entity
    end
  end

  def destroy_session
    session[:user_id] = nil
    redirect_to root_path, notice: "Sesión cerrada. ¡Vuelve pronto!"
  end

  private

  def user_params
    params.require(:user).permit(:nombre, :email, :password, :password_confirmation, :type, :bio)
  end
end
