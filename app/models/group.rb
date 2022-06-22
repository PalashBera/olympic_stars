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
end
