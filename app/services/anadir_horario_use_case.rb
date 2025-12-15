# Caso de uso para añadir un nuevo horario a un servicio
class AnadirHorarioUseCase

  # No instanciamos nada aquí, esperamos que llegue info de los repos
  def initialize(servicio_repo:, slot_repo:)
    @servicio_repo = servicio_repo
    @slot_repo = slot_repo
  end

  def ejecutar(servicio_id:, proveedor_id:, atributos_slot:)
    servicio = @servicio_repo.find(servicio_id)

    # Excepción por si algo falla
    raise StandardError, "Este no es tu servicio, no puedes añadirle horarios" unless servicio.proveedor_id == proveedor_id

    # Creamos la entidad de dominio, que sabe cómo inicializar su estado
    nuevo_slot = Entities::SlotHorario.new(atributos_slot)
    
    # Guardamos el nuevo slot a través de su repositorio
    @slot_repo.save(nuevo_slot, service_id: servicio.id)
  end
end
