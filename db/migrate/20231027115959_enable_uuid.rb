class EnableUuid < ActiveRecord::Migration[7.0]
  def change
    # For PostgreSQL, this enables the pgcrypto extension.
    # For SQLite, this is a no-op but ensures compatibility.
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  end
end
