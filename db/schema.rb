# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131008123510) do

  create_table "line_items", force: true do |t|
    t.integer  "player_id"
    t.integer  "round_id"
    t.integer  "level"
    t.decimal  "amount",     precision: 8, scale: 2
    t.boolean  "pass"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.decimal  "balance",    precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imageurl",                           default: "/assets/def_icon.jpg"
    t.boolean  "is_playing",                         default: true
    t.boolean  "pass",                               default: false
    t.boolean  "winner",                             default: false
    t.decimal  "allin",                              default: 0.0
  end

  create_table "rounds", force: true do |t|
    t.decimal  "pot",         precision: 8, scale: 2, default: 0.0
    t.decimal  "big_blind",   precision: 8, scale: 2
    t.decimal  "small_blind", precision: 8, scale: 2
    t.decimal  "call_value",  precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",                               default: 1
  end

end
