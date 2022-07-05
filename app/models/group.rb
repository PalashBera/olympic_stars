# frozen_string_literal: true

class Group < ApplicationRecord
  include UserTrackable
  include Archivable

  strip_attributes only: %i[name quota start_time end_time], collapse_spaces: true,
                   replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :account, counter_cache: true
  belongs_to :client_type
  belongs_to :teacher

  has_many :subscribers, dependent: :destroy
  has_many :students, through: :subscribers
  has_many :attendances, dependent: :destroy
  has_one :last_attendance, -> { order(date: :desc) }, class_name: "Attendance"

  delegate :name,      to: :client_type, prefix: true
  delegate :full_name, to: :teacher,     prefix: true

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false, scope: :account_id }
  validates :start_time, :end_time, presence: true, length: { maximum: 255 }
  validates :quota, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, inclusion: { in: [true, false] }

  scope :order_by_name, -> { order("LOWER(name)") }

  def schedule_set
    [
      { day: "Monday", short_day: "M", checked: monday? },
      { day: "Tuesday", short_day: "T", checked: tuesday? },
      { day: "Wednesday", short_day: "W", checked: wednesday? },
      { day: "Thursday", short_day: "Th", checked: thursday? },
      { day: "Friday", short_day: "F", checked: friday? },
      { day: "Saturday", short_day: "S", checked: saturday? }
    ]
  end

  def duration
    "#{start_time} - #{end_time}"
  end

  def schedule_days
    days = []
    days << "Monday" if monday?
    days << "Tuesday" if tuesday?
    days << "Wednesday" if wednesday?
    days << "Thrusday" if thursday?
    days << "Friday" if friday?
    days << "Saturday" if saturday?
    days.join(", ")
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def schedule_dates(month, year)
    start_date = Date.new(year.to_i, month.to_i, 1)
    end_date = start_date.end_of_month

    (start_date..end_date).select do |date|
      (date.monday? && monday?) || (date.tuesday? && tuesday?) ||
        (date.wednesday? && wednesday?) || (date.thursday? && thursday?) ||
        (date.friday? && friday?) || (date.saturday? && saturday?)
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
