# frozen_string_literal: true

class Subscriber < ApplicationRecord
  include UserTrackable

  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :student
  belongs_to :group

  delegate :full_name,        to: :student, prefix: true
  delegate :student_code,     to: :student, prefix: true
  delegate :date_of_birth,    to: :student, prefix: true
  delegate :client_type_name, to: :student, prefix: true

  validates :student_id, uniqueness: { scope: :group_id }
end
