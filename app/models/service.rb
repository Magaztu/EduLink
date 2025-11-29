class Service < ApplicationRecord
  belongs_to :provider, foreign_key: 'user_id'
  has_many :slots, class_name: 'SlotHorario', dependent: :destroy
  
  validates :titulo, presence: true
  validates :precio_base, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :duracion_minutos, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :modalidad, presence: true
end
