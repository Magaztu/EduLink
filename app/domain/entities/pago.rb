require 'securerandom'
require 'active_model'
require_relative '../enums/estado_reserva'
require_relative '../interfaces/i_pago_strategy'

module Entities
  class Pago
    include ActiveModel::Model

    attr_accessor :id, :reserva_id, :reserva, :metodo_pago, :estado, :monto_total

    def initialize(attributes = {})
      super
      @id ||= SecureRandom.uuid
      @estado ||= 'Pendiente'
    end

    # Setter personalizado para forzar el "Duck Typing" seguro
    def metodo_pago=(estrategia)
      # Validamos que el objeto sepa responder al mensaje 'procesar'
      raise ArgumentError, "La estrategia de pago debe implementar 'procesar'" unless estrategia.respond_to?(:procesar)
      @metodo_pago = estrategia
    end

    # El método asíncrono del C# se traduce a uno normalito aquí en el dominio.
    
    def aprobar
      # Validación, debe estar en estado pendiente
      raise StandardError, 'Solo se puede aprobar un pago con reserva pendiente.' unless reserva.estado == Enums::EstadoReserva::PENDIENTE

      # se pasa procesa según la estrategia de pago
      exito = @metodo_pago.procesar(@monto_total, @reserva.cliente.id)
      # Ruby asume qué interfaz está usando

      @estado = exito ? 'Aprobado' : 'Fallido'

      if exito
        @reserva.confirmar
        # ntificaciones hacer depués
      end

      exito
    end

    def puede_reembolsar?
      # solo se puede reembolsar si ya estaba aprobado
      # y si TODAVÍA se puede cancelar (estamos dentro del plazo permitido).
      @estado == 'Aprobado' && @reserva.politica_cancelacion.puede_cancelar(@reserva.slot.inicio, Time.now.utc)
    end
  end
end
