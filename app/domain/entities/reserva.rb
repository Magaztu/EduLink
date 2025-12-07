require 'securerandom'
require_relative './states/pendiente_state'
require_relative './politica_cancelacion'
require_relative './pago'
require_relative './cliente'
require_relative './servicio'
require_relative './slot_horario'

module Entities
  class Reserva
    attr_accessor :id, :cliente, :servicio, :slot, :politica_cancelacion, :pago_asociado, :estado_interno

    def initialize(cliente, servicio, slot)
      @id = SecureRandom.uuid
      @cliente = cliente
      @servicio = servicio
      @slot = slot

      # Debe recordar la politica de cancelación, pero también se incluye una por defecto
      @politica_cancelacion = Entities::PoliticaCancelacion.new(plazo_maximo_cancelacion_horas: 24, porcentaje_cargo: 0.10)
      @estado_interno = States::PendienteState.new

    end

    # Este es un getter bonito, para que desde afuera no vean el objeto de estado completo.
    def estado
      @estado_interno.nombre
    end

    def cancelar(ahora) # Ahora recibe una fecha (now)
      @estado_interno.cancelar(self, ahora)
    end

    def completar
      @estado_interno.completar(self)
    end

    def confirmar
      @estado_interno.confirmar(self)
    end
  end
end
