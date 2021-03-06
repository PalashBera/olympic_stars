# frozen_string_literal: true

class TeacherPayment < ApplicationRecord
  include UserTrackable

  STATUS_LIST = %w[created paid unpaid].freeze
  UNPAID_STATUS_LIST = %w[created unpaid].freeze
  enum status: STATUS_LIST.to_h { |item| [item, item] }

  strip_attributes only: :details, collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  after_save :update_income_and_expense

  belongs_to :payment_type,   counter_cache: true
  belongs_to :payment_method, counter_cache: true
  belongs_to :teacher

  has_one :income,  as: :income_resourcable,  dependent: :destroy
  has_one :expense, as: :expense_resourcable, dependent: :destroy

  delegate :name,      to: :payment_type,   prefix: true
  delegate :name,      to: :payment_method, prefix: true
  delegate :full_name, to: :teacher,        prefix: true

  validates :date, presence: true
  validates :work_hours, :wage_per_hour, presence: true, format: { with: VALID_DECIMAL_REGEX },
                                         numericality: { greater_than_or_equal_to: 0 }
  validates :discount, format: { with: VALID_DECIMAL_REGEX }, numericality: { greater_than_or_equal_to: 0 },
                       allow_blank: true
  validates :details, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 255 }, inclusion: { in: STATUS_LIST }

  scope :order_desc, -> { order(id: :desc) }
  scope :unpaid_payments, -> { where(status: UNPAID_STATUS_LIST) }

  def total_amount
    (work_hours * wage_per_hour) - discount.to_f
  end

  def serial
    "TP - #{id}"
  end

  def associate_income
    income || build_income
  end

  def associate_expense
    expense || build_expense
  end

  def payment_date
    date
  end

  private

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def update_income_and_expense
    if paid? && payment_type.income?
      expense&.destroy
      associate_income.update(date: payment_date, amount: total_amount)
    elsif paid? && payment_type.expense?
      income&.destroy
      associate_expense.update(date: payment_date, amount: total_amount)
    else
      income&.destroy
      expense&.destroy
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
