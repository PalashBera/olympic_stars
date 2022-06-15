class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string     :first_name,        null: false, default: "", limit: 255
      t.string     :last_name,         null: false, default: "", limit: 255
      t.date       :date_of_birth
      t.string     :student_code,      null: false, default: "", limit: 255
      t.string     :school_name,       null: false, default: "", limit: 255
      t.date       :registration_date, null: false
      t.text       :address,                        default: ""
      t.string     :allergies,                                   limit: 255
      t.string     :mother_name,       null: false, default: "", limit: 255
      t.string     :mother_email,      null: false, default: "", limit: 255
      t.string     :mother_phone,                                limit: 255
      t.string     :father_name,       null: false, default: "", limit: 255
      t.string     :father_email,      null: false, default: "", limit: 255
      t.string     :father_phone,                                limit: 255
      t.text       :remarks,                        default: ""
      t.boolean    :pro_client,        null: false, default: false
      t.boolean    :facebook,          null: false, default: false
      t.boolean    :archived,          null: false, default: false
      t.references :account,           null: false, foreign_key: true
      t.references :client_type,       null: false, foreign_key: true
      t.references :fee,               null: false, foreign_key: true
      t.bigint     :created_by_id,     index: true
      t.bigint     :updated_by_id,     index: true

      t.timestamps null: false
    end

    add_column :accounts, :students_count, :integer, default: 0, null: false
  end
end
