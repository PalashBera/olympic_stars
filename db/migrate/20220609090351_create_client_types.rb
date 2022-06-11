class CreateClientTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :client_types do |t|
      t.string     :name,          null: false, default: "", limit: 255
      t.boolean    :archived,      null: false, default: false
      t.references :account,       null: false, foreign_key: true
      t.bigint     :created_by_id, null: false, index: true
      t.bigint     :updated_by_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
