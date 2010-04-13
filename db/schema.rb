# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100413035812) do

  create_table "accounts", :force => true do |t|
    t.string   "number"
    t.string   "entity_code"
    t.string   "office_code"
    t.string   "control_code"
    t.string   "name"
    t.string   "address"
    t.string   "owner"
    t.string   "owner_address"
    t.string   "bic"
    t.string   "iban"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.string   "rol",        :default => "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "month_summaries", :force => true do |t|
    t.integer  "account_id"
    t.integer  "year"
    t.integer  "month"
    t.integer  "positive_ammount", :default => 0
    t.integer  "negative_ammount", :default => 0
    t.integer  "before_balance",   :default => 0
    t.integer  "after_balance",    :default => 0
    t.string   "tag_summary"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "month_summaries", ["month"], :name => "index_month_summaries_on_month"
  add_index "month_summaries", ["year"], :name => "index_month_summaries_on_year"

  create_table "movements", :force => true do |t|
    t.integer  "account_id"
    t.string   "code"
    t.string   "date"
    t.integer  "ammount"
    t.integer  "balance"
    t.string   "concept"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movements", ["date"], :name => "index_movements_on_date"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "movement_id"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.string  "color",      :default => "#E1E4E4"
    t.integer "account_id"
    t.integer "size",       :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
