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
  has_many :teacher_payments, dependent: :destroy
  has_one :last_teacher_payment, -> { paid.order(id: :desc) }, class_name: "TeacherPayment"

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

  def total_billed_work_hours
    teacher_payments.paid.sum(&:work_hours)
  end

  def total_unbilled_work_hours
    total_work_hours - total_billed_work_hours
  end

  def total_paid_amount
    teacher_payments.paid.sum(&:total_amount)
  end

  def total_unpaid_amount
    teacher_payments.unpaid_payments.sum(&:total_amount)
  end

  def hourly_wage
    "$#{number_with_precision(wages_per_hour, precision: 2, delimiter: ',')}" unless wages_per_hour.blank?
  end

  def daily_wage
    "$#{number_with_precision(wages_per_day, precision: 2, delimiter: ',')}" unless wages_per_day.blank?
  end

  def monthly_wage
    "$#{number_with_precision(wages_per_month, precision: 2, delimiter: ',')}" unless wages_per_month.blank?
  end

  def wages_per_hour_with_currency
    "#{hourly_wage}/hour" unless wages_per_hour.blank?
  end

  def wages_per_day_with_currency
    "#{daily_wage}/day" unless wages_per_day.blank?
  end

  def wages_per_month_with_currency
    "#{monthly_wage}/month" unless wages_per_month.blank?
  end

  def assigned_groups
    groups.pluck(:name).join(", ")
  end
end
