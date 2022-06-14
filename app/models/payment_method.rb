# frozen_string_literal: true

class PaymentMethod < ApplicationRecord
  include UserTrackable
  include Archivable

  strip_attributes only: :name, collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false, scope: :account_id }

  has_paper_trail only: %i[name archived]

  scope :order_by_name, -> { order("LOWER(name)") }
end
