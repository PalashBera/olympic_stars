class CreateWorkLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :work_logs do |t|
      t.date       :date,          null: false
      t.decimal    :hours,         null: false, precision: 12, scale: 2
      t.references :teacher,       null: false, foreign_key: true
      t.bigint     :created_by_id,              index: true
      t.bigint     :updated_by_id,              index: true

      t.timestamps null: false
    end

    add_column :teachers, :total_work_hours, :decimal, null: false, default: 0, precision: 12, scale: 2
  end
end
