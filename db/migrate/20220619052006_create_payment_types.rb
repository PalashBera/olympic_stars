class CreatePaymentTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_types do |t|
      t.string     :name,          null: false, default: "",   limit: 255
      t.string     :category,      null: false, default: "",   limit: 255
      t.boolean    :archived,      null: false, default: false
      t.references :account,       null: false, foreign_key: true
      t.bigint     :created_by_id, index: true
      t.bigint     :updated_by_id, index: true

      t.timestamps null: false
    end

    add_column :accounts, :payment_types_count, :bigint, default: 0, null: false
  end
end
