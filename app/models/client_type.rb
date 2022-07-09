# frozen_string_literal: true

class ClientType < ApplicationRecord
  include Searchable::ClientType
  include UserTrackable
  include Archivable

  strip_attributes only: :name, collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at students_count groups_count]

  belongs_to :account, counter_cache: true

  has_many :groups,   dependent: :destroy
  has_many :students, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false, scope: :account_id }

  scope :order_by_name, -> { order("LOWER(name)") }
end
