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

ActiveRecord::Schema.define(version: 20160818062743) do

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "lang"
    t.integer  "nation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nation_id"], name: "index_cities_on_nation_id", using: :btree
  end

  create_table "customer_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "customer_id"
    t.string   "cname"
    t.date     "dob"
    t.integer  "gender"
    t.integer  "country"
    t.integer  "city"
    t.integer  "province"
    t.string   "address"
    t.string   "pnumber"
    t.string   "noid"
    t.date     "issue_date"
    t.string   "issue_place"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["station_id"], name: "index_customer_records_on_station_id", using: :btree
  end

  create_table "doctor_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "fname"
    t.string   "lname"
    t.date     "dob"
    t.integer  "gender"
    t.integer  "country"
    t.integer  "city"
    t.integer  "province"
    t.string   "address"
    t.string   "pnumber"
    t.string   "noid"
    t.date     "issue_date"
    t.string   "issue_place"
    t.string   "avatar"
    t.integer  "identify"
    t.string   "noid2"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["user_id"], name: "index_doctor_profiles_on_user_id", using: :btree
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "station_id"
    t.string   "ename"
    t.integer  "country"
    t.integer  "city"
    t.integer  "province"
    t.string   "address"
    t.string   "pnumber"
    t.string   "avatar"
    t.string   "noid"
    t.integer  "gender"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.date     "time_end"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["station_id"], name: "index_employees_on_station_id", using: :btree
  end

  create_table "genders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "lang"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "lang"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "numbers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "order_map_id"
    t.integer  "room_id"
    t.integer  "number"
    t.integer  "status"
    t.date     "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["order_map_id"], name: "index_numbers_on_order_map_id", using: :btree
    t.index ["room_id"], name: "index_numbers_on_room_id", using: :btree
  end

  create_table "order_maps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_record_id"
    t.integer  "service_id"
    t.integer  "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["customer_record_id"], name: "index_order_maps_on_customer_record_id", using: :btree
    t.index ["service_id"], name: "index_order_maps_on_service_id", using: :btree
  end

  create_table "position_mappings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.integer  "position_id"
    t.datetime "time_end"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["employee_id"], name: "index_position_mappings_on_employee_id", using: :btree
    t.index ["position_id"], name: "index_position_mappings_on_position_id", using: :btree
  end

  create_table "positions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "room_id"
    t.string   "pname"
    t.string   "lang"
    t.string   "description"
    t.string   "file"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["room_id"], name: "index_positions_on_room_id", using: :btree
    t.index ["station_id"], name: "index_positions_on_station_id", using: :btree
  end

  create_table "pre_orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "user_id"
    t.datetime "time_arrived"
    t.string   "code"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["station_id"], name: "index_pre_orders_on_station_id", using: :btree
    t.index ["user_id"], name: "index_pre_orders_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "fname"
    t.string   "lname"
    t.date     "dob"
    t.integer  "gender"
    t.integer  "country"
    t.integer  "city"
    t.integer  "province"
    t.string   "address"
    t.string   "pnumber"
    t.string   "noid"
    t.date     "issue_date"
    t.string   "issue_place"
    t.string   "avatar"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "provinces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "lang"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_provinces_on_city_id", using: :btree
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.string   "lang"
    t.string   "name"
    t.string   "map"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_rooms_on_station_id", using: :btree
  end

  create_table "service_maps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "service_id"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_service_maps_on_room_id", using: :btree
    t.index ["service_id"], name: "index_service_maps_on_service_id", using: :btree
  end

  create_table "service_results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "order_map_id"
    t.integer  "user_id"
    t.string   "info"
    t.string   "result"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["order_map_id"], name: "index_service_results_on_order_map_id", using: :btree
    t.index ["user_id"], name: "index_service_results_on_user_id", using: :btree
  end

  create_table "services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.string   "sname"
    t.string   "lang"
    t.float    "price",       limit: 24
    t.string   "currency"
    t.string   "description"
    t.string   "file"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["station_id"], name: "index_services_on_station_id", using: :btree
  end

  create_table "stations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "sname"
    t.integer  "country"
    t.integer  "city"
    t.integer  "province"
    t.string   "address"
    t.string   "pnumber"
    t.string   "hpage"
    t.string   "logo"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "Noid"
    t.date     "date_issue"
    t.string   "place_issue"
    t.string   "mst"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["user_id"], name: "index_stations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "cities", "nations"
  add_foreign_key "customer_records", "stations"
  add_foreign_key "doctor_profiles", "users"
  add_foreign_key "employees", "stations"
  add_foreign_key "numbers", "order_maps"
  add_foreign_key "numbers", "rooms"
  add_foreign_key "order_maps", "customer_records"
  add_foreign_key "order_maps", "services"
  add_foreign_key "position_mappings", "employees"
  add_foreign_key "position_mappings", "positions"
  add_foreign_key "positions", "rooms"
  add_foreign_key "positions", "stations"
  add_foreign_key "pre_orders", "stations"
  add_foreign_key "pre_orders", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "provinces", "cities"
  add_foreign_key "rooms", "stations"
  add_foreign_key "service_maps", "rooms"
  add_foreign_key "service_maps", "services"
  add_foreign_key "service_results", "order_maps"
  add_foreign_key "service_results", "users"
  add_foreign_key "services", "stations"
  add_foreign_key "stations", "users"
end
