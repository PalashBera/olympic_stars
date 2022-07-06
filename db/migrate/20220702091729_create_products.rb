class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string     :name,          null: false, default: "", limit: 255
      t.decimal    :price,         null: false, precision: 12, scale: 2
      t.string     :sku,           null: false, default: "", limit: 255
      t.boolean    :archived,      null: false, default: false
      t.references :account,       null: false, foreign_key: true
      t.bigint     :created_by_id,              index: true
      t.bigint     :updated_by_id,              index: true

      t.timestamps null: false
    end
  end
end
