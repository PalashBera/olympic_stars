# frozen_string_literal: true

class StudentPayment < ApplicationRecord
  include UserTrackable

  STATUS_LIST = %w[created paid unpaid].freeze
  enum status: STATUS_LIST.to_h { |item| [item, item] }

  strip_attributes only: :details, collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  after_save :update_income_and_expense

  belongs_to :payment_type,   counter_cache: true
  belongs_to :payment_method, counter_cache: true
  belongs_to :student

  has_one :income,  as: :income_resourcable,  dependent: :destroy
  has_one :expense, as: :expense_resourcable, dependent: :destroy

  delegate :name,      to: :payment_type,   prefix: true
  delegate :name,      to: :payment_method, prefix: true
  delegate :full_name, to: :student,        prefix: true

  validates :date, presence: true
  validates :amount, presence: true, format: { with: VALID_DECIMAL_REGEX },
                     numericality: { greater_than_or_equal_to: 0 }
  validates :discount, format: { with: VALID_DECIMAL_REGEX }, numericality: { greater_than_or_equal_to: 0 },
                       allow_blank: true
  validates :details, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 255 }, inclusion: { in: STATUS_LIST }

  scope :order_desc, -> { order(id: :desc) }

  def total_amount
    amount - discount.to_f
  end

  def serial
    "SP - #{id}"
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
