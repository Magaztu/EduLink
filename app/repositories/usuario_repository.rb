require_relative '../domain/entities/cliente'
require_relative '../domain/entities/proveedor'

# El repositorio es como un traductor.
# Habla con la base de datos (con ActiveRecord) y convierte esos datos
# en nuestros objetos de dominio (los de la carpeta /domain).
class UsuarioRepository
  def find(id)
    user_record = User.find(id)
    map_to_domain_entity(user_record)
  end

  def save(domain_usuario)
    user_record = map_to_ar_model(domain_usuario)
    user_record.save!
    # Lo volvemos a mapear para devolver el objeto de dominio completo y guardado
    map_to_domain_entity(user_record)
  end

  private

  # Convierte un registro de la base de datos (ActiveRecord) a nuestro objeto de dominio
  def map_to_domain_entity(user_record)
    return nil unless user_record

    # Para saber si es Cliente o Proveedor
    domain_entity_class = case user_record.type
                          when "Provider"
                            Entities::Proveedor
                          when "Client"
                            Entities::Cliente
                          else
                            raise "Tipo de usuario desconocido: #{user_record.type}, ¡qué mandaste!"
                          end
    
    attributes = user_record.attributes.symbolize_keys.slice(:id, :nombre, :email)

    if domain_entity_class == Entities::Proveedor
      attributes[:bio] = user_record.bio
    end

    domain_entity_class.new(attributes)
  end

  # Convierte al objeto de dominio a un registro de ActiveRecord para guardarlo (o sea lo contraario)
  def map_to_ar_model(domain_usuario)
    ar_model = User.find_or_initialize_by(id: domain_usuario.id)
    ar_model.nombre = domain_usuario.nombre
    ar_model.email = domain_usuario.email

    if domain_usuario.password.present?
      ar_model.password = domain_usuario.password
    end
    
    ar_model.type = case domain_usuario
                    when Entities::Proveedor
                      "Provider"
                    when Entities::Cliente
                      "Client"
                    else
                      raise "Clase de dominio desconocida: #{domain_usuario.class}"
                    end

    if domain_usuario.is_a?(Entities::Proveedor)
      ar_model.bio = domain_usuario.bio
    end

    ar_model
  end
end
