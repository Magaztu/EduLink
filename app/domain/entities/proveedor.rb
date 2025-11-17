require_relative './usuario'
require_relative '../interfaces/i_puede_publicar'
require_relative './servicio'

module Entities
  class Proveedor < Usuario
    include Interfaces::IPuedePublicar # Declara que cumple con el contrato

    attr_accessor :bio, :servicios

    def initialize(attributes = {})
      super
      @servicios ||= []
    end

    # Implementación del método 'publicar_servicio' como exige el contrato
    def publicar_servicio(servicio) # Espera un objeto de la clase servicio
      self.servicios ||= []
      servicio.proveedor_id = self.id
      self.servicios << servicio
      servicio                     # Retorna el servicio, en ruby se omire el retun
    end
  end
end
