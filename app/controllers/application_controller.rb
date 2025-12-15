class ApplicationController < ActionController::Base

  allow_browser versions: :modern

  stale_when_importmap_changes

  helper_method :current_user, :logged_in?

  private

  def current_user
    # El ||= es un truco para no buscar en la base de datos a cada rato
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Un método rápido para saber si hay alguien logueado o no
  def logged_in?
    # Los dos !! convierten cualquier cosa a true/false
    !!current_user
  end

  def require_user
    unless logged_in?
      redirect_to login_path, alert: "Primero tienes que iniciar sesión........"
    end
  end
end
