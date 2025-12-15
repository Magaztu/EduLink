class Reservation < ApplicationRecord
  belongs_to :client, class_name: 'User', foreign_key: 'user_id'
  belongs_to :slot_horario
  has_one :payment, dependent: :destroy

  # Atributos faltantes
  attribute :plazo_maximo_cancelacion_horas, :integer
  attribute :porcentaje_cargo, :decimal

  validates :estado, presence: true
  validates :plazo_maximo_cancelacion_horas, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :porcentaje_cargo, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
end
