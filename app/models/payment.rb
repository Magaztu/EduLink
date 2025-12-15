class Payment < ApplicationRecord
  belongs_to :reservation

  validates :estado, presence: true
  validates :monto_total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :metodo_pago, presence: true
end
