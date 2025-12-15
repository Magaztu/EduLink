require 'securerandom'
require 'active_model'
require_relative '../strategies/precio_base_strategy'
require_relative '../entities/politica_cancelacion'

module Entities
  class Servicio
    include ActiveModel::Model

    attr_accessor :id, :proveedor_id, :titulo, :descripcion, :precio_base, :duracion_minutos, :modalidad, :ubicacion, :slots, :estrategia_precio, :politica_cancelacion

    def initialize(attributes = {})
      super
      @id ||= SecureRandom.uuid
      @slots ||= []

      # No es necesario definir un contexto porque ruby lo hace solito
      # Nuevamente se definen valores por defecto pero se pueden modificar con los getter/setter
      @estrategia_precio ||= Strategies::PrecioBaseStrategy.new

      @politica_cancelacion ||= PoliticaCancelacion.new(plazo_maximo_cancelacion_horas: 24, porcentaje_cargo: 0.1)
    end

    def calcular_precio_final(cliente)
      @estrategia_precio.calcular(@precio_base, cliente)
    end
  end
end
