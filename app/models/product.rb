# frozen_string_literal: true

class Product < ApplicationRecord
  include UserTrackable
  include Archivable

  strip_attributes only: %i[name price sku], collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :account, counter_cache: true

  validates :name, :sku, presence: true, length: { maximum: 255 },
                         uniqueness: { case_sensitive: false, scope: :account_id }
  validates :price, presence: true, format: { with: VALID_DECIMAL_REGEX }, numericality: { greater_than: 0 }

  scope :order_by_name, -> { order("LOWER(name)") }
end
