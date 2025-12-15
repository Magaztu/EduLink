module Events
  class ReservaConfirmadaEvent
    attr_reader :reserva_id, :cliente_nombre, :cliente_email, :servicio_titulo, :fecha_slot

    def initialize(reserva_id:, cliente_nombre:, cliente_email:, servicio_titulo:, fecha_slot:)
      @reserva_id = reserva_id
      @cliente_nombre = cliente_nombre
      @cliente_email = cliente_email
      @servicio_titulo = servicio_titulo
      @fecha_slot = fecha_slot
    end
  end
end
