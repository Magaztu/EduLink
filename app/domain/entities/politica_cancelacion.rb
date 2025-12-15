module Entities
  # Hola soy las políticas de cancelación ejjesjje

  class PoliticaCancelacion
    include ActiveModel::Model

    attr_accessor :plazo_maximo_cancelacion_horas, :porcentaje_cargo

    # ej. 24h
    # ej. 0.10 = 10%

    def initialize(attributes = {})
      super
    end

    def puede_cancelar(inicio_slot, ahora)
      # Calculamos las horas que faltan pa'l evento
      horas_restantes = (inicio_slot - ahora) / 1.hour #definido en mintuos, esto lo convierte a horas
      horas_restantes >= plazo_maximo_cancelacion_horas
    end

    def calcular_cargo(monto_total)
      monto_total * porcentaje_cargo
    end
  end
end
