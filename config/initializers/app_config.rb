require 'yaml'
require 'erb'
require 'ostruct'

# Load the configuration from the YAML file
config_file = Rails.root.join('config', 'app_config.yml')
config_erb = ERB.new(File.read(config_file)).result

# Enable aliases for YAML loading
config_yaml = YAML.safe_load(config_erb, aliases: true)

# Create a simple OpenStruct to hold the configuration
AppConfig = OpenStruct.new(config_yaml[Rails.env])

# Allow overrides via environment variables
AppConfig.tasa_impuesto = ENV['TAX_RATE'].to_f if ENV['TAX_RATE']
AppConfig.limite_servicios_gratuitos = ENV['SERVICE_LIMIT'].to_i if ENV['SERVICE_LIMIT']
