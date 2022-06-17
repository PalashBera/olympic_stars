# frozen_string_literal: true

class Student < ApplicationRecord
  include UserTrackable
  include Archivable

  strip_attributes only: %i[
    first_name last_name student_code school_name allergies mother_name
    mother_email mother_phone father_name father_email father_phone
  ], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true
  belongs_to :client_type
  belongs_to :fee

  delegate :name, to: :client_type, prefix: true
  delegate :name, to: :fee,         prefix: true

  validates :first_name, :last_name, :mother_name, :father_name, presence: true, length: { maximum: 255 }
  validates :student_code, presence: true, length: { maximum: 255 },
                           uniqueness: { case_sensitive: false, scope: :account_id }
  validates :mother_email, :father_email, presence: true, length: { maximum: 255 },
                                          format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, :registration_date, presence: true
  validates :school_name, :allergies, :mother_phone, :father_phone, length: { maximum: 255 }
  validates :pro_client, :facebook, inclusion: { in: [true, false] }

  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  scope :order_by_first_name, -> { order("LOWER(first_name)") }

  def full_name
    [first_name, last_name].join(" ")
  end
end
