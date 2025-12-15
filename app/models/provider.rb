class Provider < User
  # Corresponde a la entidad del dominio "Proveedor"
  has_many :services, foreign_key: 'user_id', dependent: :destroy
end
