class CreateSubscribers < ActiveRecord::Migration[7.0]
  def change
    create_table :subscribers do |t|
      t.references :student,       null: false, foreign_key: true
      t.references :group,         null: false, foreign_key: true
      t.string     :state,         default: "–", limit: 255
      t.bigint     :created_by_id, index: true
      t.bigint     :updated_by_id, index: true

      t.timestamps
    end
  end
end
