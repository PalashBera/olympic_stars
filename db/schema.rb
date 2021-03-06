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

ActiveRecord::Schema[7.0].define(version: 2022_07_02_091729) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.string "time_zone", limit: 50, default: "UTC", null: false
    t.bigint "client_types_count", default: 0, null: false
    t.bigint "courses_count", default: 0, null: false
    t.bigint "payment_methods_count", default: 0, null: false
    t.bigint "teachers_count", default: 0, null: false
    t.bigint "students_count", default: 0, null: false
    t.bigint "groups_count", default: 0, null: false
    t.bigint "payment_types_count", default: 0, null: false
    t.bigint "cash_books_count", default: 0, null: false
    t.bigint "products_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.date "date", null: false
    t.bigint "group_id", null: false
    t.bigint "subscriber_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_attendances_on_created_by_id"
    t.index ["group_id"], name: "index_attendances_on_group_id"
    t.index ["subscriber_id"], name: "index_attendances_on_subscriber_id"
    t.index ["updated_by_id"], name: "index_attendances_on_updated_by_id"
  end

  create_table "cash_books", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "cash_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "card_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "withdrawn_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "leftover_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_cash_books_on_account_id"
    t.index ["created_by_id"], name: "index_cash_books_on_created_by_id"
    t.index ["updated_by_id"], name: "index_cash_books_on_updated_by_id"
  end

  create_table "client_types", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "students_count", default: 0, null: false
    t.bigint "groups_count", default: 0, null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_client_types_on_account_id"
    t.index ["created_by_id"], name: "index_client_types_on_created_by_id"
    t.index ["updated_by_id"], name: "index_client_types_on_updated_by_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.decimal "fee", precision: 12, scale: 2, default: "0.0", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "students_count", default: 0, null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_courses_on_account_id"
    t.index ["created_by_id"], name: "index_courses_on_created_by_id"
    t.index ["updated_by_id"], name: "index_courses_on_updated_by_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.string "expense_resourcable_type", null: false
    t.bigint "expense_resourcable_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_expenses_on_created_by_id"
    t.index ["expense_resourcable_type", "expense_resourcable_id"], name: "index_expenses_on_expense_resourcable"
    t.index ["updated_by_id"], name: "index_expenses_on_updated_by_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.integer "quota", null: false
    t.string "start_time", limit: 255, default: "", null: false
    t.string "end_time", limit: 255, default: "", null: false
    t.boolean "monday", default: false, null: false
    t.boolean "tuesday", default: false, null: false
    t.boolean "wednesday", default: false, null: false
    t.boolean "thursday", default: false, null: false
    t.boolean "friday", default: false, null: false
    t.boolean "saturday", default: false, null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "teacher_id", null: false
    t.bigint "client_type_id", null: false
    t.bigint "subscribers_count", default: 0, null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_groups_on_account_id"
    t.index ["client_type_id"], name: "index_groups_on_client_type_id"
    t.index ["created_by_id"], name: "index_groups_on_created_by_id"
    t.index ["teacher_id"], name: "index_groups_on_teacher_id"
    t.index ["updated_by_id"], name: "index_groups_on_updated_by_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.string "income_resourcable_type", null: false
    t.bigint "income_resourcable_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_incomes_on_created_by_id"
    t.index ["income_resourcable_type", "income_resourcable_id"], name: "index_incomes_on_income_resourcable"
    t.index ["updated_by_id"], name: "index_incomes_on_updated_by_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "student_payments_count", default: 0, null: false
    t.bigint "teacher_payments_count", default: 0, null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payment_methods_on_account_id"
    t.index ["created_by_id"], name: "index_payment_methods_on_created_by_id"
    t.index ["updated_by_id"], name: "index_payment_methods_on_updated_by_id"
  end

  create_table "payment_types", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.string "category", limit: 255, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "student_payments_count", default: 0, null: false
    t.bigint "teacher_payments_count", default: 0, null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payment_types_on_account_id"
    t.index ["created_by_id"], name: "index_payment_types_on_created_by_id"
    t.index ["updated_by_id"], name: "index_payment_types_on_updated_by_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.decimal "price", precision: 12, scale: 2, null: false
    t.string "sku", limit: 255, default: "", null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_products_on_account_id"
    t.index ["created_by_id"], name: "index_products_on_created_by_id"
    t.index ["updated_by_id"], name: "index_products_on_updated_by_id"
  end

  create_table "student_payments", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.decimal "discount", precision: 12, scale: 2
    t.string "details", limit: 255
    t.string "status", limit: 255, default: "created", null: false
    t.bigint "student_id", null: false
    t.bigint "payment_type_id", null: false
    t.bigint "payment_method_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_student_payments_on_created_by_id"
    t.index ["payment_method_id"], name: "index_student_payments_on_payment_method_id"
    t.index ["payment_type_id"], name: "index_student_payments_on_payment_type_id"
    t.index ["student_id"], name: "index_student_payments_on_student_id"
    t.index ["updated_by_id"], name: "index_student_payments_on_updated_by_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name", limit: 255, default: "", null: false
    t.string "last_name", limit: 255, default: "", null: false
    t.string "student_code", limit: 255, default: "", null: false
    t.date "date_of_birth", null: false
    t.string "school_name", limit: 255, default: ""
    t.string "allergies", limit: 255, default: ""
    t.date "registration_date", null: false
    t.string "mother_name", limit: 255, default: "", null: false
    t.string "mother_email", limit: 255, default: "", null: false
    t.string "mother_phone_number", limit: 255
    t.string "father_name", limit: 255, default: "", null: false
    t.string "father_email", limit: 255, default: "", null: false
    t.string "father_phone_number", limit: 255
    t.text "address", default: ""
    t.text "remarks", default: ""
    t.boolean "pro_client", default: false, null: false
    t.boolean "facebook", default: false, null: false
    t.boolean "archived", default: false, null: false
    t.bigint "account_id", null: false
    t.bigint "client_type_id", null: false
    t.bigint "course_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_students_on_account_id"
    t.index ["client_type_id"], name: "index_students_on_client_type_id"
    t.index ["course_id"], name: "index_students_on_course_id"
    t.index ["created_by_id"], name: "index_students_on_created_by_id"
    t.index ["updated_by_id"], name: "index_students_on_updated_by_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "group_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_subscribers_on_created_by_id"
    t.index ["group_id"], name: "index_subscribers_on_group_id"
    t.index ["student_id"], name: "index_subscribers_on_student_id"
    t.index ["updated_by_id"], name: "index_subscribers_on_updated_by_id"
  end

  create_table "teacher_payments", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "work_hours", precision: 12, scale: 2, null: false
    t.decimal "wage_per_hour", precision: 12, scale: 2, null: false
    t.decimal "discount", precision: 12, scale: 2
    t.string "details", limit: 255
    t.string "status", limit: 255, default: "created", null: false
    t.bigint "teacher_id", null: false
    t.bigint "payment_type_id", null: false
    t.bigint "payment_method_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_teacher_payments_on_created_by_id"
    t.index ["payment_method_id"], name: "index_teacher_payments_on_payment_method_id"
    t.index ["payment_type_id"], name: "index_teacher_payments_on_payment_type_id"
    t.index ["teacher_id"], name: "index_teacher_payments_on_teacher_id"
    t.index ["updated_by_id"], name: "index_teacher_payments_on_updated_by_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name", limit: 255, default: "", null: false
    t.string "last_name", limit: 255, default: "", null: false
    t.string "email", limit: 255, default: "", null: false
    t.date "date_of_birth"
    t.string "phone_number", limit: 255
    t.string "mobile_number", limit: 255
    t.decimal "wages_per_hour", precision: 12, scale: 2
    t.decimal "wages_per_day", precision: 12, scale: 2
    t.decimal "wages_per_month", precision: 12, scale: 2
    t.text "availability"
    t.boolean "archived", default: false, null: false
    t.decimal "total_work_hours", precision: 12, scale: 2, default: "0.0", null: false
    t.bigint "account_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_teachers_on_account_id"
    t.index ["created_by_id"], name: "index_teachers_on_created_by_id"
    t.index ["updated_by_id"], name: "index_teachers_on_updated_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 255, default: "", null: false
    t.string "last_name", limit: 255, default: "", null: false
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "active", default: true, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.bigint "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255, null: false
    t.text "object_changes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "work_logs", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "hours", precision: 12, scale: 2, null: false
    t.bigint "teacher_id", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_work_logs_on_created_by_id"
    t.index ["teacher_id"], name: "index_work_logs_on_teacher_id"
    t.index ["updated_by_id"], name: "index_work_logs_on_updated_by_id"
  end

  add_foreign_key "attendances", "groups"
  add_foreign_key "attendances", "subscribers"
  add_foreign_key "cash_books", "accounts"
  add_foreign_key "client_types", "accounts"
  add_foreign_key "courses", "accounts"
  add_foreign_key "groups", "accounts"
  add_foreign_key "groups", "client_types"
  add_foreign_key "groups", "teachers"
  add_foreign_key "payment_methods", "accounts"
  add_foreign_key "payment_types", "accounts"
  add_foreign_key "products", "accounts"
  add_foreign_key "student_payments", "payment_methods"
  add_foreign_key "student_payments", "payment_types"
  add_foreign_key "student_payments", "students"
  add_foreign_key "students", "accounts"
  add_foreign_key "students", "client_types"
  add_foreign_key "students", "courses"
  add_foreign_key "subscribers", "groups"
  add_foreign_key "subscribers", "students"
  add_foreign_key "teacher_payments", "payment_methods"
  add_foreign_key "teacher_payments", "payment_types"
  add_foreign_key "teacher_payments", "teachers"
  add_foreign_key "teachers", "accounts"
  add_foreign_key "work_logs", "teachers"
end
