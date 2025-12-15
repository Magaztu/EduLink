class Inquiry < ApplicationRecord
  TOPICS = ["Reportar Problema", "Añadir Sugerencia"]

  validates :topic, presence: true, inclusion: { in: TOPICS }
  validates :body, presence: true, length: { maximum: 400 }
end
