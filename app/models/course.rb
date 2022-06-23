# frozen_string_literal: true

class Course < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  include UserTrackable
  include Archivable

  strip_attributes only: %i[name fee], collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :account, counter_cache: true

  has_many :students, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :fee, presence: true, format: { with: VALID_DECIMAL_REGEX },
                  numericality: { greater_than_or_equal_to: 0 }

  scope :order_by_name, -> { order("LOWER(name)") }

  def fee_with_currency
    "$#{number_with_precision(fee, precision: 2, delimiter: ',')}" unless fee.blank?
  end
end
