require 'securerandom'
require 'active_model'

module Entities
  class Usuario
    include ActiveModel::Model

    attr_accessor :id, :nombre, :email, :password

    def initialize(attributes = {})
      super
      @id ||= SecureRandom.uuid # asigna un id unico y aleatorio si no exite la db,
                                # es como guid de C#
    end
  end
end
