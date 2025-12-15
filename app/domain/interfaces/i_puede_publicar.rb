module Interfaces
  module IPuedePublicar
    # Define el contrato para una entidad que puede publicar servicios.
    # La clase que incluya este módulo DEBE implementar el método 'publicar_servicio'.
    def publicar_servicio(servicio)
      raise NotImplementedError, "#{self.class} debe implementar el método 'publicar_servicio'"
    end
  end
end
