require 'active_model'

module Entities
  module Usuario
    include ActiveModel::Model

    attr_accessor :id, :nombre, :email

    def initialize(attributes = {})
      super
    end
  end
end
