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

ActiveRecord::Schema.define(version: 20161118094443) do

  create_table "apikeys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "appid"
    t.string   "soapi"
    t.string   "mapi"
    t.string   "adminapi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adminapi"], name: "index_apikeys_on_adminapi", unique: true, using: :btree
    t.index ["appid"], name: "index_apikeys_on_appid", unique: true, using: :btree
    t.index ["mapi"], name: "index_apikeys_on_mapi", unique: true, using: :btree
    t.index ["soapi"], name: "index_apikeys_on_soapi", unique: true, using: :btree
    t.index ["user_id"], name: "index_apikeys_on_user_id", using: :btree
  end

  create_table "bill_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "remark",       limit: 65535
    t.integer  "dvi"
    t.integer  "sluong"
    t.float    "tpayment",     limit: 24
    t.float    "discount",     limit: 24
    t.float    "tpayout",      limit: 24
    t.integer  "order_map_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "c_id"
    t.integer  "station_id"
    t.string   "c_name"
    t.index ["order_map_id"], name: "index_bill_infos_on_order_map_id", using: :btree
    t.index ["station_id"], name: "index_bill_infos_on_station_id", using: :btree
  end

  create_table "c_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "d_a"
    t.text     "c_c",        limit: 65535
    t.text     "c_content",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "check_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ename"
    t.integer  "e_id"
    t.integer  "status"
    t.date     "daystart"
    t.date     "dayend"
    t.text     "kluan",        limit: 65535
    t.text     "cdoan",        limit: 65535
    t.text     "hdieutri",     limit: 65535
    t.integer  "order_map_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "c_id"
    t.integer  "station_id"
    t.string   "c_name"
    t.index ["order_map_id"], name: "index_check_infos_on_order_map_id", using: :btree
    t.index ["station_id"], name: "index_check_infos_on_station_id", using: :btree
  end

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
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "avatar"
    t.text     "work_place",          limit: 65535
    t.text     "self_history",        limit: 65535
    t.text     "family_history",      limit: 65535
    t.text     "drug_history",        limit: 65535
    t.index ["station_id"], name: "index_customer_records_on_station_id", using: :btree
  end

  create_table "demo_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "sname"
    t.string   "pnumber"
    t.datetime "demotime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doc_cats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "icon_link"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doc_cons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "doc_subs_id"
    t.string   "header"
    t.text     "content",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["doc_subs_id"], name: "index_doc_cons_on_doc_subs_id", using: :btree
  end

  create_table "doc_subs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "doc_cats_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["doc_cats_id"], name: "index_doc_subs_on_doc_cats_id", using: :btree
  end

  create_table "doctor_check_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "daycheck"
    t.string   "ename"
    t.integer  "e_id"
    t.text     "qtbenhly",     limit: 65535
    t.text     "klamsang",     limit: 65535
    t.integer  "nhiptim"
    t.float    "nhietdo",      limit: 24
    t.integer  "hamin"
    t.integer  "hamax"
    t.integer  "ntho"
    t.float    "cnang",        limit: 24
    t.float    "cao",          limit: 24
    t.text     "cdbandau",     limit: 65535
    t.text     "bktheo",       limit: 65535
    t.text     "cdicd",        limit: 65535
    t.text     "kluan",        limit: 65535
    t.integer  "order_map_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "c_id"
    t.integer  "station_id"
    t.string   "c_name"
    t.index ["order_map_id"], name: "index_doctor_check_infos_on_order_map_id", using: :btree
    t.index ["station_id"], name: "index_doctor_check_infos_on_station_id", using: :btree
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
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
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
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["station_id"], name: "index_employees_on_station_id", using: :btree
  end

  create_table "genders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "lang"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medicine_bill_ins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "billcode"
    t.date     "dayin"
    t.string   "supplier"
    t.date     "daybook"
    t.integer  "pmethod"
    t.float    "tpayment",    limit: 24
    t.float    "discount",    limit: 24
    t.float    "tpayout",     limit: 24
    t.text     "remark",      limit: 65535
    t.integer  "status"
    t.integer  "station_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "supplier_id"
    t.index ["station_id"], name: "index_medicine_bill_ins_on_station_id", using: :btree
  end

  create_table "medicine_bill_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "bill_id"
    t.string   "name"
    t.string   "company"
    t.string   "noid"
    t.string   "signid"
    t.date     "expire"
    t.integer  "pmethod"
    t.integer  "qty"
    t.float    "taxrate",    limit: 24
    t.float    "price",      limit: 24
    t.text     "remark",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "billcode"
    t.integer  "sample_id"
    t.integer  "company_id"
    t.index ["station_id"], name: "index_medicine_bill_records_on_station_id", using: :btree
  end

  create_table "medicine_companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "address"
    t.string   "pnumber"
    t.string   "noid"
    t.string   "email"
    t.string   "website"
    t.string   "taxcode"
    t.integer  "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_medicine_companies_on_station_id", using: :btree
  end

  create_table "medicine_external_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "customer_id"
    t.integer  "script_id"
    t.string   "name"
    t.integer  "amount"
    t.text     "remark",      limit: 65535
    t.string   "company"
    t.float    "price",       limit: 24
    t.float    "total",       limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "cname"
    t.string   "script_code"
    t.integer  "sample_id"
    t.integer  "company_id"
    t.index ["station_id"], name: "index_medicine_external_records_on_station_id", using: :btree
  end

  create_table "medicine_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "remark",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "medicine_internal_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "customer_id"
    t.integer  "script_id"
    t.string   "name"
    t.integer  "amount"
    t.string   "noid"
    t.string   "signid"
    t.text     "remark",      limit: 65535
    t.string   "company"
    t.float    "price",       limit: 24
    t.float    "discount",    limit: 24
    t.float    "tpayment",    limit: 24
    t.integer  "status"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "cname"
    t.string   "script_code"
    t.integer  "sample_id"
    t.integer  "company_id"
    t.index ["station_id"], name: "index_medicine_internal_records_on_station_id", using: :btree
  end

  create_table "medicine_prescript_externals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.string   "code"
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.integer  "result_id"
    t.string   "number_id"
    t.date     "date"
    t.string   "address"
    t.text     "remark",      limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "cname"
    t.string   "ename"
    t.index ["station_id"], name: "index_medicine_prescript_externals_on_station_id", using: :btree
  end

  create_table "medicine_prescript_internals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.string   "code"
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.integer  "result_id"
    t.string   "number_id"
    t.date     "date"
    t.string   "preparer"
    t.string   "payer"
    t.float    "tpayment",    limit: 24
    t.float    "discount",    limit: 24
    t.float    "tpayout",     limit: 24
    t.integer  "pmethod"
    t.text     "remark",      limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "cname"
    t.string   "ename"
    t.integer  "preparer_id"
    t.index ["station_id"], name: "index_medicine_prescript_internals_on_station_id", using: :btree
  end

  create_table "medicine_prices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.string   "name"
    t.integer  "minam"
    t.float    "price",      limit: 24
    t.text     "remark",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "sample_id"
    t.index ["station_id"], name: "index_medicine_prices_on_station_id", using: :btree
  end

  create_table "medicine_rights", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "user_id"
    t.integer  "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_medicine_rights_on_station_id", using: :btree
  end

  create_table "medicine_samples", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "typemedicine"
    t.string   "name"
    t.integer  "groupmedicine"
    t.string   "company"
    t.float    "price",         limit: 24
    t.float    "weight",        limit: 24
    t.text     "remark",        limit: 65535
    t.integer  "expire"
    t.integer  "station_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "noid"
    t.integer  "company_id"
    t.index ["station_id"], name: "index_medicine_samples_on_station_id", using: :btree
  end

  create_table "medicine_stock_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "typerecord"
    t.string   "name"
    t.string   "noid"
    t.string   "signid"
    t.integer  "amount"
    t.date     "expire"
    t.string   "supplier"
    t.integer  "internal_record_id"
    t.integer  "bill_in_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "bill_in_code"
    t.string   "internal_record_code"
    t.text     "remark",               limit: 65535
    t.integer  "sample_id"
    t.integer  "supplier_id"
    t.index ["station_id"], name: "index_medicine_stock_records_on_station_id", using: :btree
  end

  create_table "medicine_suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "contactname"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "spnumber"
    t.string   "pnumber"
    t.string   "noid"
    t.string   "email"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "fax"
    t.string   "taxcode"
    t.integer  "station_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["station_id"], name: "index_medicine_suppliers_on_station_id", using: :btree
  end

  create_table "medicine_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "remark",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "nations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "lang"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "news_sub_category_id"
    t.string   "title"
    t.text     "content",              limit: 65535
    t.integer  "views",                              default: 0
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "news_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news_contents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "news_header_id"
    t.text     "content",        limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["news_header_id"], name: "index_news_contents_on_news_header_id", using: :btree
  end

  create_table "news_headers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cat"
    t.string   "image_f"
    t.text     "title",      limit: 65535
    t.text     "des",        limit: 65535
    t.integer  "view"
    t.boolean  "recomend"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "news_sub_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "news_category_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "order_maps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_record_id"
    t.integer  "service_id"
    t.integer  "status"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "cname"
    t.string   "sername"
    t.float    "tpayment",           limit: 24
    t.float    "discount",           limit: 24
    t.float    "tpayout",            limit: 24
    t.text     "remark",             limit: 65535
    t.string   "code"
    t.integer  "station_id"
    t.index ["customer_record_id"], name: "index_order_maps_on_customer_record_id", using: :btree
    t.index ["service_id"], name: "index_order_maps_on_service_id", using: :btree
    t.index ["station_id"], name: "index_order_maps_on_station_id", using: :btree
  end

  create_table "outside_currencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "remark",     limit: 65535
    t.integer  "category"
    t.integer  "station_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["station_id"], name: "index_outside_currencies_on_station_id", using: :btree
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "station_id"
    t.boolean  "c_permit",   default: false
    t.boolean  "r_permit",   default: false
    t.boolean  "u_permit",   default: false
    t.boolean  "d_permit",   default: false
    t.integer  "table_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "position_mappings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.integer  "position_id"
    t.datetime "time_end"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "station_id"
    t.string   "ename"
    t.string   "pname"
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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "rname"
    t.index ["room_id"], name: "index_positions_on_room_id", using: :btree
    t.index ["station_id"], name: "index_positions_on_station_id", using: :btree
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
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "work_place",          limit: 65535
    t.text     "self_history",        limit: 65535
    t.text     "family_history",      limit: 65535
    t.text     "drug_history",        limit: 65535
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
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "map_file_name"
    t.string   "map_content_type"
    t.integer  "map_file_size"
    t.datetime "map_updated_at"
    t.index ["station_id"], name: "index_rooms_on_station_id", using: :btree
  end

  create_table "service_maps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "service_id"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "station_id"
    t.string   "sname"
    t.string   "rname"
    t.index ["room_id"], name: "index_service_maps_on_room_id", using: :btree
    t.index ["service_id"], name: "index_service_maps_on_service_id", using: :btree
  end

  create_table "services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.string   "sname"
    t.string   "lang"
    t.float    "price",             limit: 24
    t.string   "currency"
    t.string   "description"
    t.string   "file"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
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
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.index ["user_id"], name: "index_stations_on_user_id", using: :btree
  end

  create_table "support_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.text     "comment",                 limit: 65535
    t.string   "attachment"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["user_id"], name: "index_support_comments_on_user_id", using: :btree
  end

  create_table "support_tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "title",                   limit: 65535
    t.text     "infomation",              limit: 65535
    t.string   "attachment"
    t.integer  "status"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["user_id"], name: "index_support_tickets_on_user_id", using: :btree
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
    t.integer  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "visit_bills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "customer_id"
    t.string   "cname"
    t.string   "placecode"
    t.integer  "billtype"
    t.integer  "status"
    t.integer  "pmethod"
    t.float    "tpayment",    limit: 24
    t.float    "discount",    limit: 24
    t.float    "tpayout",     limit: 24
    t.string   "billcode"
    t.text     "remark",      limit: 65535
    t.date     "billdate"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["station_id"], name: "index_visit_bills_on_station_id", using: :btree
  end

  add_foreign_key "apikeys", "users"
  add_foreign_key "bill_infos", "order_maps"
  add_foreign_key "bill_infos", "stations"
  add_foreign_key "check_infos", "order_maps"
  add_foreign_key "check_infos", "stations"
  add_foreign_key "cities", "nations"
  add_foreign_key "customer_records", "stations"
  add_foreign_key "doc_cons", "doc_subs", column: "doc_subs_id"
  add_foreign_key "doc_subs", "doc_cats", column: "doc_cats_id"
  add_foreign_key "doctor_check_infos", "order_maps"
  add_foreign_key "doctor_check_infos", "stations"
  add_foreign_key "doctor_profiles", "users"
  add_foreign_key "employees", "stations"
  add_foreign_key "medicine_bill_ins", "stations"
  add_foreign_key "medicine_bill_records", "stations"
  add_foreign_key "medicine_companies", "stations"
  add_foreign_key "medicine_external_records", "stations"
  add_foreign_key "medicine_internal_records", "stations"
  add_foreign_key "medicine_prescript_externals", "stations"
  add_foreign_key "medicine_prescript_internals", "stations"
  add_foreign_key "medicine_prices", "stations"
  add_foreign_key "medicine_rights", "stations"
  add_foreign_key "medicine_samples", "stations"
  add_foreign_key "medicine_stock_records", "stations"
  add_foreign_key "medicine_suppliers", "stations"
  add_foreign_key "news_contents", "news_headers"
  add_foreign_key "order_maps", "customer_records"
  add_foreign_key "order_maps", "services"
  add_foreign_key "order_maps", "stations"
  add_foreign_key "outside_currencies", "stations"
  add_foreign_key "position_mappings", "employees"
  add_foreign_key "position_mappings", "positions"
  add_foreign_key "positions", "rooms"
  add_foreign_key "positions", "stations"
  add_foreign_key "profiles", "users"
  add_foreign_key "provinces", "cities"
  add_foreign_key "rooms", "stations"
  add_foreign_key "service_maps", "rooms"
  add_foreign_key "service_maps", "services"
  add_foreign_key "services", "stations"
  add_foreign_key "stations", "users"
  add_foreign_key "support_comments", "users"
  add_foreign_key "support_tickets", "users"
  add_foreign_key "visit_bills", "stations"
end
