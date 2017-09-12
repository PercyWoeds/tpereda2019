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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20170913204660) do
=======
ActiveRecord::Schema.define(version: 20170203155504) do
>>>>>>> edf88f4801b75546828b758d5a6c590cc8d5ef1d

  create_table "clients", force: :cascade do |t|
    t.string   "vcodigo"
    t.string   "vruc"
    t.string   "vrazon2"
    t.string   "vdireccion"
    t.string   "vdistrito"
    t.string   "vprov"
    t.string   "vdep"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "mailclient"
    t.string   "mailclient2"
    t.string   "mailclient3"
  end

  create_table "invoices", force: :cascade do |t|
    t.string   "cliente"
    t.date     "fecha"
    t.string   "td"
    t.string   "serie"
    t.string   "numero"
    t.decimal  "preciocigv"
    t.decimal  "preciosigv"
    t.float    "cantidad"
    t.float    "vventa"
    t.float    "igv"
    t.float    "importe"
    t.string   "ruc"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "guia"
    t.string   "codplaca10"
    t.string   "formapago"
    t.text     "description"
    t.text     "comments"
    t.string   "descrip"
    t.integer  "moneda"
  end

  create_table "mailings", force: :cascade do |t|
    t.string   "td"
    t.string   "serie"
    t.string   "numero"
    t.string   "ruc"
    t.boolean  "flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "flag1"
  end

<<<<<<< HEAD
  create_table "nota", force: :cascade do |t|
    t.string   "code"
    t.string   "descrip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notacredits", force: :cascade do |t|
    t.datetime "fecha"
    t.string   "code"
    t.integer  "nota_id"
    t.string   "motivo"
    t.float    "subtotal"
    t.float    "tax"
    t.float    "total"
    t.integer  "moneda_id"
    t.string   "mod_factura"
    t.integer  "mod_tipo"
    t.string   "processed"
    t.string   "tipo"
    t.string   "description"
    t.integer  "customer_id"
    t.float    "quantity"
    t.float    "price"
    t.float    "price2"
    t.integer  "client_id"
    t.integer  "notum_id"
    t.string   "nombre"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

=======
>>>>>>> edf88f4801b75546828b758d5a6c590cc8d5ef1d
  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "permission_level"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "voideds", force: :cascade do |t|
    t.string   "numero"
    t.string   "serie"
    t.string   "factura"
    t.date     "fecha"
    t.text     "texto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
