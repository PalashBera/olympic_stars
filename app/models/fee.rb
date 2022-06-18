# frozen_string_literal: true

class Fee < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  include UserTrackable
  include Archivable

  strip_attributes only: %i[name amount], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :amount, presence: true, format: { with: VALID_DECIMAL_REGEX },
                     numericality: { greater_than_or_equal_to: 0 }

  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  scope :order_by_name, -> { order("LOWER(name)") }

  def amount_with_currency
    "$#{number_with_precision(amount, precision: 2, delimiter: ',')}" unless amount.blank?
  end
end
