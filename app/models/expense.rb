# frozen_string_literal: true

class Expense < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  include UserTrackable

  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :expense_resourcable, polymorphic: true

  delegate :payment_method_id,   to: :expense_resourcable
  delegate :payment_method_name, to: :expense_resourcable
  delegate :payment_type_id,     to: :expense_resourcable
  delegate :payment_type_name,   to: :expense_resourcable

  validates :date, presence: true
  validates :amount, presence: true, format: { with: VALID_DECIMAL_REGEX },
                     numericality: { greater_than_or_equal_to: 0 }

  scope :order_desc, -> { order(id: :desc) }

  def amount_with_currency
    "$#{number_with_precision(amount, precision: 2, delimiter: ',')}"
  end

  def resouce_name
    case expense_resourcable
    when TeacherPayment
      expense_resourcable.teacher_full_name
    when StudentPayment
      expense_resourcable.student_full_name
    else
      "Unknown"
    end
  end
end
