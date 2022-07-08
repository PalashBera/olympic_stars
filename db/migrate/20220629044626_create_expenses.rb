class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.date       :date,                null: false
      t.decimal    :amount,              null: false, precision: 12, scale: 2
      t.belongs_to :expense_resourcable, null: false, polymorphic: true
      t.bigint     :created_by_id,                    index: true
      t.bigint     :updated_by_id,                    index: true

      t.timestamps null: false
    end
  end
end
