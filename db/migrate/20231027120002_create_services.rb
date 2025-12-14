class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :titulo, null: false
      t.text :descripcion
      t.decimal :precio_base, precision: 18, scale: 2, null: false
      t.integer :duracion_minutos, null: false
      t.string :modalidad, null: false
      t.string :ubicacion

      t.timestamps
    end
  end
end
