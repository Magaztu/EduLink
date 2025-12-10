module Interfaces
  module IPuedeReservar
    # Define el contrato para una entidad que puede realizar reservas.
    # La clase que incluya este módulo DEBE implementar el método 'reservar'.
    def reservar(servicio, slot)
      raise NotImplementedError, "#{self.class} debe implementar el método 'reservar'"
    end
  end
end
