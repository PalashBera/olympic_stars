# frozen_string_literal: true

class Account < ApplicationRecord
  strip_attributes only: %i[name time_zone], collapse_spaces: true, replace_newlines: true

  has_many :client_types, dependent: :destroy
  has_many :fees, dependent: :destroy
  has_many :payment_methods, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :time_zone, presence: true, length: { maximum: 50 }

  has_paper_trail only: %i[name time_zone]
end
