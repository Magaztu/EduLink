# Este caso de uso es para que un proveedor pueda cambiar la disponibilidad de sus slots.
class GestionarDisponibilidadUseCase

  def initialize(slot_repo:, servicio_repo:)
    @slot_repo = slot_repo
    @servicio_repo = servicio_repo
  end

  def bloquear_slot(slot_id:, proveedor_id:)
    slot = @slot_repo.find(slot_id)
    servicio = @servicio_repo.find(slot.service_id)

    raise StandardError, "No eres el dueño de este servicio..." unless servicio.proveedor_id == proveedor_id

    slot.bloquear
    @slot_repo.save(slot)
  end

  def desbloquear_slot(slot_id:, proveedor_id:)
    slot = @slot_repo.find(slot_id)
    servicio = @servicio_repo.find(slot.service_id)

    raise StandardError, "Este no es tu servicio." unless servicio.proveedor_id == proveedor_id

    slot.desbloquear
    @slot_repo.save(slot)
  end
end
