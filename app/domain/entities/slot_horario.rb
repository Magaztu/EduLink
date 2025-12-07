require 'securerandom'
require 'active_model'
require_relative './states/slot/disponible_state'

module Entities
  class SlotHorario
    include ActiveModel::Model

    attr_accessor :id, :service_id, :inicio, :fin, :cupo_max, :cupo_actual, :estado_interno

    def initialize(attributes = {})
      super
      @id ||= SecureRandom.uuid
      @cupo_actual ||= 0

      # Valor por defecto, pero inyectable con attributes[:estado_interno]
      @estado_interno ||= States::Slot::DisponibleState.new
    end

    # Posibles opciones de aki
    def estado
      @estado_interno.nombre
    end

    def reservar
      @estado_interno.reservar(self)
    end

    def cancelar
      @estado_interno.cancelar(self)
    end

    def expirar
      @estado_interno.expirar(self)
    end

    def bloquear
      @estado_interno.bloquear(self)
    end

    def desbloquear
      @estado_interno.desbloquear(self)
    end
  end
end
