class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string     :name,           null: false, default: "",   limit: 255
      t.decimal    :fee,            null: false, default: 0,    precision: 12, scale: 2
      t.boolean    :archived,       null: false, default: false
      t.references :account,        null: false,                foreign_key: true
      t.bigint     :students_count, null: false, default: 0
      t.bigint     :created_by_id,               index: true
      t.bigint     :updated_by_id,               index: true

      t.timestamps null: false
    end
  end
end
