class CreateTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers do |t|
      t.string     :first_name,      null: false, default: "", limit: 255
      t.string     :last_name,       null: false, default: "", limit: 255
      t.string     :email,           null: false, default: "", limit: 255
      t.string     :phone_number,                              limit: 255
      t.string     :mobile_number,                             limit: 255
      t.decimal    :wages_per_hour,               default: 0,  precision: 12, scale: 2
      t.decimal    :wages_per_day,                default: 0,  precision: 12, scale: 2
      t.decimal    :wages_per_month,              default: 0,  precision: 12, scale: 2
      t.date       :date_of_birth
      t.text       :availability
      t.boolean    :archived,        null: false, default: false
      t.references :account,         null: false, foreign_key: true
      t.bigint     :created_by_id,   index: true
      t.bigint     :updated_by_id,   index: true

      t.timestamps null: false
    end

    add_column :accounts, :teachers_count, :integer, default: 0, null: false
  end
end
