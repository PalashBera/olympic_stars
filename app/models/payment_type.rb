# frozen_string_literal: true

class PaymentType < ApplicationRecord
  include UserTrackable
  include Archivable

  CATEGORY_LIST = %w[income expense].freeze

  enum category: CATEGORY_LIST.to_h { |item| [item, item] }

  strip_attributes only: %i[name category], collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :account, counter_cache: true

  has_many :student_payments, dependent: :destroy
  has_many :teacher_payments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :category, presence: true, length: { maximum: 255 }, inclusion: { in: CATEGORY_LIST }

  scope :order_by_name, -> { order("LOWER(name)") }
end
