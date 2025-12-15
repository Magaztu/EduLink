class Client < User
  # Corresponde a la entidad del dominio "Cliente"
  has_many :reservations, foreign_key: 'user_id', dependent: :restrict_with_exception
end
