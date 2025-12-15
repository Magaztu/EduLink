class CreateInquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :inquiries, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :topic, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
