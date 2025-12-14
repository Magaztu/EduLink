class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :nombre, null: false
      t.string :email, null: false
      t.string :type, null: false
      t.text :bio
      t.string :password_digest
      t.string :verification_code
      t.datetime :verification_code_sent_at

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
