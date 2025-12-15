class AddCancellationPolicyToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :plazo_cancelacion, :integer, default: 24, null: false
    add_column :services, :porcentaje_cargo, :decimal, precision: 5, scale: 4, default: 0.1, null: false
  end
end
