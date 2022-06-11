# frozen_string_literal: true

class Account < ApplicationRecord
  strip_attributes only: %i[name time_zone], collapse_spaces: true, replace_newlines: true

  has_many :client_types, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :time_zone, presence: true, length: { maximum: 50 }
end
