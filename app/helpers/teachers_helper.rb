# frozen_string_literal: true

module TeachersHelper
  def hourly_wage_with_currency(wage)
    "#{amount_with_currency(wage)}/hour" unless wage.blank?
  end

  def daily_wage_with_currency(wage)
    "#{amount_with_currency(wage)}/day" unless wage.blank?
  end

  def monthly_wage_with_currency(wage)
    "#{amount_with_currency(wage)}/month" unless wage.blank?
  end
end
