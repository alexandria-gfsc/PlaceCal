# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181005091853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.string "street_address"
    t.string "street_address2"
    t.string "street_address3"
    t.string "city"
    t.string "postcode"
    t.string "country_code", default: "UK"
    t.float "latitude"
    t.float "longitude"
    t.bigint "neighbourhood_id"
    t.index ["neighbourhood_id"], name: "index_addresses_on_neighbourhood_id"
  end

  create_table "calendars", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "source"
    t.jsonb "notices"
    t.datetime "last_import_at"
    t.integer "partner_id"
    t.integer "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "strategy"
    t.string "last_checksum"
    t.text "critical_error"
    t.string "page_access_token"
    t.boolean "is_working", default: true, null: false
    t.index ["partner_id"], name: "index_calendars_on_partner_id"
    t.index ["place_id"], name: "index_calendars_on_place_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "collections_events", id: false, force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.bigint "event_id", null: false
    t.index ["collection_id", "event_id"], name: "index_collections_events_on_collection_id_and_event_id"
    t.index ["event_id", "collection_id"], name: "index_collections_events_on_event_id_and_collection_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.integer "place_id"
    t.integer "calendar_id"
    t.string "uid"
    t.text "summary"
    t.text "description"
    t.text "location"
    t.jsonb "rrule"
    t.jsonb "notices"
    t.boolean "is_active", default: true, null: false
    t.datetime "dtstart"
    t.datetime "dtend"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "partner_id"
    t.integer "address_id"
    t.string "are_spaces_available"
    t.text "footer"
    t.index ["calendar_id"], name: "index_events_on_calendar_id"
    t.index ["place_id"], name: "index_events_on_place_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "neighbourhoods", force: :cascade do |t|
    t.string "name"
  end

  create_table "partners", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "public_phone"
    t.string "public_email"
    t.string "admin_name"
    t.string "admin_email"
    t.text "short_description"
    t.integer "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_a_place"
    t.string "slug"
    t.string "partner_email"
    t.string "partner_name"
    t.string "partner_phone"
    t.string "calendar_email"
    t.string "calendar_phone"
    t.string "calendar_name"
    t.string "public_name"
    t.string "url"
    t.index ["address_id"], name: "index_partners_on_address_id"
    t.index ["slug"], name: "index_partners_on_slug", unique: true
  end

  create_table "partners_places", id: :serial, force: :cascade do |t|
    t.integer "partner_id"
    t.integer "place_id"
    t.index ["partner_id"], name: "index_partners_places_on_partner_id"
    t.index ["place_id"], name: "index_partners_places_on_place_id"
  end

  create_table "partners_turfs", id: false, force: :cascade do |t|
    t.bigint "partner_id", null: false
    t.bigint "turf_id", null: false
    t.index ["partner_id", "turf_id"], name: "index_partners_turfs_on_partner_id_and_turf_id"
    t.index ["turf_id", "partner_id"], name: "index_partners_turfs_on_turf_id_and_partner_id"
  end

  create_table "partners_users", id: :serial, force: :cascade do |t|
    t.integer "partner_id"
    t.integer "user_id"
    t.index ["partner_id"], name: "index_partners_users_on_partner_id"
    t.index ["user_id"], name: "index_partners_users_on_user_id"
  end

  create_table "places", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "logo"
    t.string "phone"
    t.jsonb "opening_times"
    t.text "short_description"
    t.text "booking_info"
    t.text "accessibility_info"
    t.integer "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "url"
    t.string "slug"
    t.index ["address_id"], name: "index_places_on_address_id"
    t.index ["slug"], name: "index_places_on_slug", unique: true
  end

  create_table "places_turfs", id: false, force: :cascade do |t|
    t.bigint "place_id", null: false
    t.bigint "turf_id", null: false
    t.index ["place_id", "turf_id"], name: "index_places_turfs_on_place_id_and_turf_id"
    t.index ["turf_id", "place_id"], name: "index_places_turfs_on_turf_id_and_place_id"
  end

  create_table "seed_migration_data_migrations", id: :integer, default: nil, force: :cascade do |t|
    t.string "version"
    t.integer "runtime"
    t.datetime "migrated_on"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "domain"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_admin_id"
    t.string "logo"
    t.string "hero_image"
    t.string "hero_image_credit"
    t.string "footer_logo"
    t.index ["site_admin_id"], name: "index_sites_on_site_admin_id"
  end

  create_table "sites_neighbourhoods", force: :cascade do |t|
    t.integer "neighbourhood_id"
    t.integer "site_id"
    t.string "relation_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites_supporters", id: false, force: :cascade do |t|
    t.bigint "site_id", null: false
    t.bigint "supporter_id", null: false
    t.index ["site_id", "supporter_id"], name: "index_sites_supporters_on_site_id_and_supporter_id"
    t.index ["supporter_id", "site_id"], name: "index_sites_supporters_on_supporter_id_and_site_id"
  end

  create_table "supporters", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "logo"
    t.string "description"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_global", default: false
  end

  create_table "turfs", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turfs_users", id: false, force: :cascade do |t|
    t.bigint "turf_id", null: false
    t.bigint "user_id", null: false
    t.index ["turf_id", "user_id"], name: "index_turfs_users_on_turf_id_and_user_id"
    t.index ["user_id", "turf_id"], name: "index_turfs_users_on_user_id_and_turf_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "phone"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.string "access_token_expires_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "addresses", "neighbourhoods"
  add_foreign_key "calendars", "partners"
  add_foreign_key "calendars", "places"
  add_foreign_key "events", "addresses"
  add_foreign_key "events", "calendars"
  add_foreign_key "events", "partners"
  add_foreign_key "events", "places"
  add_foreign_key "partners", "addresses"
  add_foreign_key "partners_places", "partners"
  add_foreign_key "partners_places", "places"
  add_foreign_key "partners_users", "partners"
  add_foreign_key "partners_users", "users"
  add_foreign_key "places", "addresses"
  add_foreign_key "sites", "users", column: "site_admin_id"
end
