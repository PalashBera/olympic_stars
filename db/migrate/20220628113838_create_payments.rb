class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.date       :date,           null: false
      t.decimal    :amount,         null: false, precision: 12, scale: 2
      t.decimal    :discount,                    precision: 12, scale: 2
      t.string     :details,                                         limit: 255
      t.string     :status,         null: false, default: "created", limit: 255
      t.belongs_to :payable,        null: false, polymorphic: true
      t.references :payment_type,   null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.bigint     :created_by_id, index: true
      t.bigint     :updated_by_id, index: true

      t.timestamps null: false
    end
  end
end
