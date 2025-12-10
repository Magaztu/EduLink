module Interfaces
  module IPrecioStrategy
    def calcular(precio_base, cliente)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end
