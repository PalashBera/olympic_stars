# frozen_string_literal: true

class Student < ApplicationRecord
  include UserTrackable
  include Archivable

  strip_attributes only: %i[
    first_name last_name school_name allergies student_code mother_name mother_phone
    mother_email father_name father_phone father_email
  ], collapse_spaces: true, replace_newlines: true

  belongs_to :account, counter_cache: true
  belongs_to :client_type
  belongs_to :fee

  delegate :name, to: :client_type, prefix: true
  delegate :name, to: :fee,         prefix: true

  validates :first_name, :last_name, :school_name, :student_code, :mother_name, :father_name, presence: true,
                                                                                              length: { maximum: 255 }
  validates :mother_email, :father_email, presence: true, length: { maximum: 255 },
                                          format: { with: URI::MailTo::EMAIL_REGEXP },
                                          uniqueness: { case_sensitive: false, scope: :account_id }
  validates :registration_date, presence: true
  validates :allergies, :mother_phone, :father_phone, length: { maximum: 255 }
  validates :pro_client, :facebook, inclusion: { in: [true, false] }

  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  scope :order_by_first_name, -> { order("LOWER(first_name)") }

  def full_name
    [first_name, last_name].join(" ")
  end
end
