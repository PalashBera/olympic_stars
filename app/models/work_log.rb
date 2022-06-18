# frozen_string_literal: true

class WorkLog < ApplicationRecord
  include UserTrackable

  belongs_to :teacher

  delegate :full_name, to: :teacher, prefix: true

  validates :date, presence: true, uniqueness: { scope: :teacher_id }
  validates :hours, presence: true, format: { with: VALID_DECIMAL_REGEX }, numericality: { greater_than_or_equal_to: 0 }

  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  scope :order_by_date, -> { order("date desc") }
end
