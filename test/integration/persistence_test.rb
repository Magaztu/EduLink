require "test_helper"
require_relative "../../app/repositories/usuario_repository"
require_relative "../../app/repositories/servicio_repository"
require_relative "../../app/domain/entities/cliente"
require_relative "../../app/domain/entities/proveedor"
require_relative "../../app/domain/entities/servicio"

class PersistenceTest < ActionDispatch::IntegrationTest
  # Instanciar objetos de las clases para usar en la prueba
  def setup
    @usuario_repo = UsuarioRepository.new
    @servicio_repo = ServicioRepository.new
  end

  test "persistencia completa de un Cliente" do
    # Crear entidad de dominio

    cliente_dominio = Entities::Cliente.new(
      nombre: "Juan Persistencia",
      email: "juan@test.com",
      password: "password123" 
    )

    # Guardar usando el repositorio
    guardado = @usuario_repo.save(cliente_dominio)

    # Verificar que se guardó en la BD real
    cliente_db = User.find_by(email: "juan@test.com")
    
    assert_not_nil cliente_db
    assert_equal "Juan Persistencia", cliente_db.nombre
    assert_equal "Client", cliente_db.type
    assert_equal guardado.id, cliente_db.id
  end

  test "persistencia completa de un Proveedor y su Servicio" do
    # Crear y guardar Proveedor
    proveedor = Entities::Proveedor.new(
      nombre: "Profe Carlos",
      email: "carlos@test.com",
      password: "password123",
      bio: "Experto en Ruby"
    )
    @usuario_repo.save(proveedor)

    # Crear Servicio asociado
    servicio = Entities::Servicio.new(
      titulo: "Curso de Rails",
      descripcion: "Aprende Rails desde cero",
      precio_base: 50.0,
      duracion_minutos: 60,
      modalidad: "Online",
      proveedor_id: proveedor.id
    )

    # Guardar Servicio
    @servicio_repo.save(servicio)

    # Verificar en BD
    servicio_db = Service.find_by(titulo: "Curso de Rails")
    
    assert_not_nil servicio_db
    assert_equal 50.0, servicio_db.precio_base
    assert_equal proveedor.id, servicio_db.user_id
    # Verificar que la relación funciona
    assert_equal "Profe Carlos", servicio_db.provider.nombre
  end
end
