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

ActiveRecord::Schema.define(version: 20171217181205) do

  create_table "identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=ujis" do |t|
    t.bigint "user_id"
    t.string "uid", null: false
    t.integer "provider", null: false
    t.string "nickname"
    t.string "email"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "identity_githubs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=ujis" do |t|
    t.bigint "identity_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_identity_githubs_on_identity_id"
  end

  create_table "identity_twitters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=ujis" do |t|
    t.bigint "identity_id"
    t.string "token"
    t.string "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_identity_twitters_on_identity_id"
  end

  create_table "invitations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=ujis" do |t|
    t.bigint "team_id"
    t.string "token"
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_invitations_on_team_id"
  end

  create_table "members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=ujis" do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_members_on_team_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=ujis" do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.bigint "task_id"
    t.datetime "at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_records_on_task_id"
    t.index ["team_id"], name: "index_records_on_team_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=ujis" do |t|
    t.bigint "team_id"
    t.integer "order"
    t.string "name", default: "", null: false
    t.string "background_color"
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_tasks_on_team_id"
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=ujis" do |t|
    t.string "name"
    t.boolean "deleted", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=ujis" do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "invitations", "teams"
  add_foreign_key "members", "teams"
  add_foreign_key "members", "users"
  add_foreign_key "records", "tasks"
  add_foreign_key "records", "teams"
  add_foreign_key "records", "users"
  add_foreign_key "tasks", "teams"
end
