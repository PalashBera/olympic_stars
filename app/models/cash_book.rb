# frozen_string_literal: true

class CashBook < ApplicationRecord
  include UserTrackable

  strip_attributes only: %i[cash_amount card_amount withdrawn_amount leftover_amount], collapse_spaces: true,
                   replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :account, counter_cache: true

  validates :date, presence: true, uniqueness: { scope: :account_id }
  validates :cash_amount, :card_amount, format: { with: VALID_DECIMAL_REGEX },
                                        numericality: { greater_than_or_equal_to: 0 }
  validates :withdrawn_amount, :leftover_amount, format: { with: VALID_DECIMAL_REGEX },
                                                 numericality: { greater_than_or_equal_to: 0 }
  validate :validate_amounts

  scope :order_by_date, -> { order(date: :desc) }

  private

  def validate_amounts
    if cash_amount != withdrawn_amount + leftover_amount
      errors.add(:cash_amount, :invalid)
      errors.add(:leftover_amount, :invalid)
      errors.add(:withdrawn_amount, :invalid)
    end
  end
end
