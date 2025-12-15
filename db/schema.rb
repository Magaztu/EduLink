# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_12_14_214455) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "inquiries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.string "topic", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "estado", null: false
    t.string "metodo_pago", null: false
    t.decimal "monto_total", precision: 18, scale: 2, null: false
    t.uuid "reservation_id", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_payments_on_reservation_id"
  end

  create_table "reservations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "estado", null: false
    t.integer "plazo_maximo_cancelacion_horas", null: false
    t.decimal "porcentaje_cargo", precision: 5, scale: 4, null: false
    t.uuid "slot_horario_id", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["slot_horario_id"], name: "index_reservations_on_slot_horario_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "descripcion"
    t.integer "duracion_minutos", null: false
    t.string "image_url"
    t.string "modalidad", null: false
    t.integer "plazo_cancelacion", default: 24, null: false
    t.decimal "porcentaje_cargo", precision: 5, scale: 4, default: "0.1", null: false
    t.decimal "precio_base", precision: 18, scale: 2, null: false
    t.string "titulo", null: false
    t.string "ubicacion"
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "slot_horarios", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "cupo_actual", default: 0, null: false
    t.integer "cupo_max", default: 1, null: false
    t.string "estado", null: false
    t.datetime "fin", null: false
    t.datetime "inicio", null: false
    t.uuid "service_id", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_slot_horarios_on_service_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "nombre", null: false
    t.string "password_digest"
    t.string "type", null: false
    t.datetime "updated_at", null: false
    t.string "verification_code"
    t.datetime "verification_code_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "payments", "reservations", on_delete: :cascade
  add_foreign_key "reservations", "slot_horarios", on_delete: :restrict
  add_foreign_key "reservations", "users", on_delete: :restrict
  add_foreign_key "services", "users"
  add_foreign_key "slot_horarios", "services", on_delete: :cascade
end
