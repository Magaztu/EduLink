class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :user, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
      t.references :slot_horario, type: :uuid, null: false, foreign_key: { on_delete: :restrict }
      t.string :estado, null: false
      t.integer :plazo_maximo_cancelacion_horas, null: false
      t.decimal :porcentaje_cargo, precision: 5, scale: 4, null: false

      t.timestamps
    end
  end
end
