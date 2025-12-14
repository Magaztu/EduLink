class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :reservation, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.string :estado, null: false
      t.decimal :monto_total, precision: 18, scale: 2, null: false
      t.string :metodo_pago, null: false

      t.timestamps
    end
  end
end
