# frozen_string_literal: true

module SessionsHelper
  def current_account
    # TODO: Need to accociate user with account
    @current_account ||= Account.first
  end

  def month_start_date
    Date.current.beginning_of_month
  end

  def month_end_date
    Date.current.end_of_month
  end
end
