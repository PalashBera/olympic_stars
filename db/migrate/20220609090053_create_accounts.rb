class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name,                  null: false, default: "",    limit: 255
      t.string :time_zone,             null: false, default: "UTC", limit: 50
      t.bigint :client_types_count,    null: false, default: 0
      t.bigint :courses_count,         null: false, default: 0
      t.bigint :payment_methods_count, null: false, default: 0
      t.bigint :teachers_count,        null: false, default: 0
      t.bigint :students_count,        null: false, default: 0
      t.bigint :groups_count,          null: false, default: 0
      t.bigint :payment_types_count,   null: false, default: 0

      t.timestamps null: false
    end
  end
end
