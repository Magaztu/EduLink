class PasswordResetsController < ApplicationController
  layout 'auth'

  before_action :set_user_from_session, only: [:verify, :check_verification, :edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.update(
        verification_code: 6.times.map { rand(10) }.join,
        verification_code_sent_at: Time.current
      )
      UserMailer.password_reset(@user).deliver_now
      session[:password_reset_user_id] = @user.id
      redirect_to verify_password_reset_path, notice: "Se ha enviado un código a tu correo."
    else
      flash.now[:alert] = "No se encontró un usuario con ese correo."
      render :new, status: :unprocessable_entity
    end
  end

  def verify
  end

  def check_verification
    if @user.verification_code == params[:code] && @user.verification_code_sent_at > 15.minutes.ago
      session[:password_reset_verified_at] = Time.current.to_s
      redirect_to edit_password_reset_path
    else
      flash.now[:alert] = "Código inválido o expirado."
      render :verify, status: :unprocessable_entity
    end
  end

  def edit
    # Renders the edit form
  end

  def update
    verified_at = session[:password_reset_verified_at] ? Time.parse(session[:password_reset_verified_at]) : nil

    if verified_at && verified_at > 15.minutes.ago
      if @user.update(password_params)
        session.delete(:password_reset_user_id)
        session.delete(:password_reset_verified_at)
        redirect_to login_path, notice: "Contraseña actualizada con éxito. Por favor, inicia sesión."
      else

        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to new_password_reset_path, alert: "El proceso de restablecimiento ha expirado. Por favor, inténtalo de nuevo."
    end
  end

  private

  def set_user_from_session
    user_id = session[:password_reset_user_id]
    redirect_to new_password_reset_path, alert: "Proceso de restablecimiento no iniciado." unless user_id
    @user = User.find(user_id)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
