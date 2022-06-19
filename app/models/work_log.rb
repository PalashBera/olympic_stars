# frozen_string_literal: true

class WorkLog < ApplicationRecord
  include UserTrackable

  after_save :update_teacher_total_work_hours
  after_destroy :update_teacher_total_work_hours

  strip_attributes only: :hours, collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :teacher

  delegate :full_name, to: :teacher, prefix: true

  validates :date, presence: true, uniqueness: { scope: :teacher_id }
  validates :hours, presence: true, format: { with: VALID_DECIMAL_REGEX }, numericality: { greater_than: 0 }

  scope :this_week, -> { where("date >= ? AND date <= ?", Date.current.beginning_of_week, Date.current.end_of_week) }
  scope :this_month, -> { where("date >= ? AND date <= ?", Date.current.beginning_of_month, Date.current.end_of_month) }
  scope :this_year, -> { where("date >= ? AND date <= ?", Date.current.beginning_of_year, Date.current.end_of_year) }

  private

  def update_teacher_total_work_hours
    teacher.update_columns(total_work_hours: teacher.work_logs.sum(&:hours))
  end
end
