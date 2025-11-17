require_relative './usuario'
require_relative '../interfaces/i_puede_reservar'
require_relative '../enums/estado_slot'
require_relative './reserva'

# Forward declarations
class Servicio; end
class SlotHorario; end

module Entities
  class Cliente < Usuario
    include Interfaces::IPuedeReservar # Declara que cumple con el contrato

    attr_accessor :historial, :metodos_pago_tokenizados

    def initialize(attributes = {})
      super
      @historial ||= []
      @metodos_pago_tokenizados ||= []
    end

    # Implementación del método 'reservar' como exige el contrato
    def reservar(servicio, slot)

      nueva_reserva = Entities::Reserva.new(self, servicio, slot)
      self.historial << nueva_reserva
      
      nueva_reserva
    end
  end
end
