# frozen_string_literal: true

class PaymentType < ApplicationRecord
  include UserTrackable
  include Archivable

  strip_attributes only: :name, collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :account, counter_cache: true

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false, scope: :account_id }

  scope :order_by_name, -> { order("LOWER(name)") }
end
