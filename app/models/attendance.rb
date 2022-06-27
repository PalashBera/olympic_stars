# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :group
  belongs_to :subscriber

  validates :date, presence: true, uniqueness: { scope: %i[group_id subscriber_id] }

  scope :by_date_range, lambda { |month, year|
                          where("EXTRACT(MONTH FROM date) = ? AND EXTRACT(YEAR FROM date) = ?", month, year)
                        }

  def attended?(subscriber, schedule_date)
    date == schedule_date && subscriber_id == subscriber.id
  end
end
