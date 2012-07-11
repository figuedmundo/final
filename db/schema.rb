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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120628195501) do

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "place_id"
  end

  add_index "comments", ["user_id", "created_at"], :name => "index_comments_on_user_id_and_created_at"

  create_table "photos", :force => true do |t|
    t.string   "desc"
    t.integer  "place_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.spatial  "coord",      :limit => {:srid=>3785, :type=>"point"}
    t.string   "desc"
    t.string   "address"
    t.integer  "user_id"
  end

  add_index "places", ["coord"], :name => "index_places_on_coord", :spatial => true

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "remember_token"
    t.string   "name"
    t.string   "last_name"
    t.boolean  "admin",           :default => false
    t.string   "avatar"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "vertices_tmp", :id => false, :force => true do |t|
    t.integer "id",                                                :null => false
    t.spatial "the_geom", :limit => {:srid=>3785, :type=>"point"}
  end

  add_index "vertices_tmp", ["the_geom"], :name => "vertices_tmp_idx", :spatial => true

  create_table "ways", :primary_key => "gid", :force => true do |t|
    t.string   "name"
    t.float    "dist"
    t.integer  "source"
    t.integer  "target"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.spatial  "the_geom",   :limit => {:srid=>3785, :type=>"line_string"}
  end

  add_index "ways", ["source"], :name => "index_ways_on_source"
  add_index "ways", ["target"], :name => "index_ways_on_target"
  add_index "ways", ["the_geom"], :name => "index_ways_on_the_geom", :spatial => true

end
