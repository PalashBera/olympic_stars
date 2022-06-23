# frozen_string_literal: true

class Teacher < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  include UserTrackable
  include Archivable

  strip_attributes only: %i[
    first_name last_name email phone_number mobile_number
    wages_per_day wages_per_hour wages_per_month
  ], collapse_spaces: true, replace_newlines: true
  has_paper_trail except: %i[created_by_id updated_by_id updated_at]

  belongs_to :account, counter_cache: true

  has_many :work_logs, dependent: :destroy
  has_many :groups,    dependent: :destroy

  validates :first_name, :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false, scope: :account_id }
  validates :wages_per_hour, :wages_per_day, :wages_per_month, format: { with: VALID_DECIMAL_REGEX },
                                                               numericality: { greater_than: 0 },
                                                               allow_blank: true
  validates :phone_number, :mobile_number, length: { maximum: 255 }

  scope :order_by_first_name, -> { order("LOWER(first_name)") }

  def full_name
    [first_name, last_name].join(" ")
  end

  def this_week_work_hours
    work_logs.this_week.sum(&:hours)
  end

  def this_month_work_hours
    work_logs.this_month.sum(&:hours)
  end

  def this_year_work_hours
    work_logs.this_year.sum(&:hours)
  end

  def wages_per_hour_with_currency
    "$#{number_with_precision(wages_per_hour, precision: 2, delimiter: ',')}/hour" unless wages_per_hour.blank?
  end

  def wages_per_day_with_currency
    "$#{number_with_precision(wages_per_day, precision: 2, delimiter: ',')}/day" unless wages_per_day.blank?
  end

  def wages_per_month_with_currency
    "$#{number_with_precision(wages_per_month, precision: 2, delimiter: ',')}/month" unless wages_per_month.blank?
  end

  def assigned_groups
    groups.pluck(:name).join(", ")
  end
end
