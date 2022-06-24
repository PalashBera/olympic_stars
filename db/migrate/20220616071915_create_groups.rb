class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string     :name,        null: false, default: "", limit: 255
      t.integer    :quota,       null: false
      t.string     :start_time,  null: false, default: "", limit: 255
      t.string     :end_time,    null: false, default: "", limit: 255
      t.boolean    :monday,      null: false, default: false
      t.boolean    :tuesday,     null: false, default: false
      t.boolean    :wednesday,   null: false, default: false
      t.boolean    :thursday,    null: false, default: false
      t.boolean    :friday,      null: false, default: false
      t.boolean    :saturday,    null: false, default: false
      t.boolean    :archived,    null: false, default: false
      t.references :account,     null: false, foreign_key: true
      t.references :teacher,     null: false, foreign_key: true
      t.references :client_type, null: false, foreign_key: true
      t.bigint     :created_by_id,            index: true
      t.bigint     :updated_by_id,            index: true

      t.timestamps null: false
    end
  end
end
