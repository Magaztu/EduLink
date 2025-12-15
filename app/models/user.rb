class User < ApplicationRecord
  # Pg encripta sólo la contra
  has_secure_password

  # En rails 'type' es la columna que manda.
  self.inheritance_column = :type

  # Se ejecuta antes de validar, solo cuando se crea un usuario nuevo
  before_validation :generate_uuid, on: :create

  # Reglas de validación, para no guardar basura en la BD
  validates :nombre, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :type, presence: true, inclusion: { in: %w(Client Provider) }
  # La contraseña solo se valida si es un registro nuevo o si se está cambiando
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  private

  # Si no tenemos un ID, creamos un UUID para que la base de datos no se queje
  def generate_uuid
    self.id ||= SecureRandom.uuid
  end
end
