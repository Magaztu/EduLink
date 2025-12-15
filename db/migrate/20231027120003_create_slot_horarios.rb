class CreateSlotHorarios < ActiveRecord::Migration[7.0]
  def change
    create_table :slot_horarios, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :service, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.datetime :inicio, null: false
      t.datetime :fin, null: false
      t.integer :cupo_max, null: false, default: 1
      t.integer :cupo_actual, null: false, default: 0
      t.string :estado, null: false

      t.timestamps
    end
  end
end
