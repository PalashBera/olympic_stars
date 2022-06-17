class CreateFees < ActiveRecord::Migration[7.0]
  def change
    create_table :fees do |t|
      t.string     :name,          null: false, default: "",   limit: 255
      t.decimal    :amount,        null: false, default: 0,    precision: 12, scale: 2
      t.boolean    :archived,      null: false, default: false
      t.references :account,       null: false,                foreign_key: true
      t.bigint     :created_by_id, index: true
      t.bigint     :updated_by_id, index: true

      t.timestamps null: false
    end

    add_column :accounts, :fees_count, :bigint, default: 0, null: false
  end
end