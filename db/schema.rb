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

ActiveRecord::Schema.define(:version => 20150102044802) do

  create_table "crawled_pages", :force => true do |t|
    t.string   "type"
    t.string   "digest"
    t.string   "url"
    t.text     "html"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "listings", :force => true do |t|
    t.string   "title"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.decimal  "lat",                       :precision => 10, :scale => 6
    t.decimal  "lon",                       :precision => 10, :scale => 6
    t.string   "contact"
    t.string   "contact_phones"
    t.string   "contact_emails"
    t.string   "contact_method"
    t.string   "website"
    t.string   "updated_on"
    t.string   "description"
    t.string   "internship_starts_on"
    t.string   "internship_ends_on"
    t.string   "num_interns"
    t.string   "app_deadline"
    t.string   "minimum_stay_length"
    t.string   "meals"
    t.string   "skills_desired"
    t.string   "educational_opportunities"
    t.string   "stipend"
    t.string   "housing"
    t.string   "internship_details"
    t.integer  "attra_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

end
