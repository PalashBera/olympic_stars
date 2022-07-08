class CreateCashBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :cash_books do |t|
      t.date       :date,             null: false
      t.decimal    :cash_amount,      null: false, precision: 12, scale: 2, default: "0.00"
      t.decimal    :card_amount,      null: false, precision: 12, scale: 2, default: "0.00"
      t.decimal    :withdrawn_amount, null: false, precision: 12, scale: 2, default: "0.00"
      t.decimal    :leftover_amount,  null: false, precision: 12, scale: 2, default: "0.00"
      t.references :account,          null: false, foreign_key: true
      t.bigint     :created_by_id,                 index: true
      t.bigint     :updated_by_id,                 index: true

      t.timestamps null: false
    end
  end
end
