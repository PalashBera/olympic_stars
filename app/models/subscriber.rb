# frozen_string_literal: true

class Subscriber < ApplicationRecord
  include UserTrackable

  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :student
  belongs_to :group

  has_many :attendances, dependent: :destroy
  has_one :last_attendance, -> { order(date: :desc) }, class_name: "Attendance"

  delegate :full_name,        to: :student, prefix: true
  delegate :student_code,     to: :student, prefix: true
  delegate :client_type_name, to: :student, prefix: true
  delegate :course_name,      to: :student, prefix: true

  validates :student_id, uniqueness: { scope: :group_id }

  scope :order_by_name, -> { joins(:student).order("students.first_name") }
end
