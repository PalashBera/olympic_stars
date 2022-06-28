# frozen_string_literal: true

class Income < ApplicationRecord
  include UserTrackable

  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :income_resourcable, polymorphic: true

  validates :date, presence: true
  validates :amount, presence: true, format: { with: VALID_DECIMAL_REGEX },
                     numericality: { greater_than_or_equal_to: 0 }

  scope :order_desc, -> { order(id: :desc) }
end
