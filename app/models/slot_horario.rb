class SlotHorario < ApplicationRecord
  belongs_to :service
  has_many :reservations, dependent: :restrict_with_exception

  validates :inicio, presence: true
  validates :fin, presence: true
  validates :cupo_max, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cupo_actual, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :estado, presence: true

  # Validación personalizada para las fechas
  validate :fin_debe_ser_posterior_a_inicio

  private

  def fin_debe_ser_posterior_a_inicio
    # Asegurar que ambas fechas existan antes de compararlas
    return if fin.blank? || inicio.blank?

    if fin <= inicio
      errors.add(:fin, "debe ser posterior a la fecha y hora de inicio")
    end
  end
end
