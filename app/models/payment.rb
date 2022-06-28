# frozen_string_literal: true

class Payment < ApplicationRecord
  include UserTrackable

  STATUS_LIST = %w[created paid unpaid].freeze
  enum status: STATUS_LIST.to_h { |item| [item, item] }

  strip_attributes only: :details, collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :payment_type
  belongs_to :payment_method
  belongs_to :payable, polymorphic: true

  delegate :name, to: :payment_type,   prefix: true
  delegate :name, to: :payment_method, prefix: true

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
    "P - #{id}"
  end
end
