class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.date       :date,          null: false
      t.references :group,         null: false, foreign_key: true
      t.references :subscriber,    null: false, foreign_key: true
      t.bigint     :created_by_id, index: true
      t.bigint     :updated_by_id, index: true

      t.timestamps null: false
    end
  end
end
