require "test_helper"

class PasswordResetFlowTest < ActionDispatch::IntegrationTest # Aqui se le indica a minitest que esta prueba es de integración y no unitaria
  
  def setup
    # SSe Crea un usuario real en la base de datos para la prueba
    @user = User.create!(
      nombre: "Usuario de Prueba",
      email: "test@example.com",
      password: "password123",
      type: "Client"
    )
  end

  test "el flujo de reseteo de contraseña envía un correo" do
    # Ir a la página de solicitar reseteo
    get new_password_reset_path               #se valida un GET
    assert_response :success              # assert response es como el = de python

    # Enviar el formulario con el correo del usuario
    # Usamos assert_emails para verificar que el bloque de código envía un correo
    assert_emails 1 do
      post password_reset_path, params: { email: @user.email }
    end

    # Verificar redirección a la página de verificación
    assert_redirected_to verify_password_reset_path

    # 4. Se jace una inspeccion del correo enviado
    sent_email = ActionMailer::Base.deliveries.last
    assert_not_nil sent_email
    assert_equal [@user.email], sent_email.to

    # El asunto debe ser el de abajito
    assert_equal "Restablecimiento de Contraseña", sent_email.subject
    
    # Usar el código de verificacion en el correo
    @user.reload # Recarga el usuario en la base de datos
    assert_match @user.verification_code, sent_email.body.to_s # Compara que el código en la db y el recogido sean el mismo
  end
end
