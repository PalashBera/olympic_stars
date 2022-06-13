class CreateVersions < ActiveRecord::Migration[7.0]
  TEXT_BYTES = 1_073_741_823

  def change
    create_table :versions do |t|
      t.string :item_type,      limit: 255, null: false
      t.bigint :item_id,                    null: false
      t.string :event,          limit: 255, null: false
      t.string :whodunnit,      limit: 255, null: false
      t.text   :object_changes, limit: TEXT_BYTES

      t.timestamps null: false
    end

    add_index :versions, %i(item_type item_id)
  end
end
