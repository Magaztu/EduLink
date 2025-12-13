require "test_helper"
require_relative "../../../app/domain/entities/proveedor"
require_relative "../../../app/domain/entities/servicio"

class ProveedorTest < ActiveSupport::TestCase

  test "un proveedor puede publicar un nuevo servicio" do
    # Preparo mis datos
    profe_carlos = Entities::Proveedor.new(id: "profe-001", nombre: "Carlos")
    
    curso_de_ruby = Entities::Servicio.new(
      titulo: "Ruby para Principiantes",
      precio_base: 100
    )

    # Hago la acción
    profe_carlos.publicar_servicio(curso_de_ruby)

    # Verifico los resultados
    # El servicio debe estar en la lista del proveedor
    assert_equal 1, profe_carlos.servicios.size
    # El servicio ahora debe saber quién es su proveedor
    assert_equal "profe-001", curso_de_ruby.proveedor_id
  end
end
