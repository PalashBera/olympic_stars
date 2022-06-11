# frozen_string_literal: true

module SessionsHelper
  def current_account
    # TODO: Need to accociate user with account
    @current_account ||= Account.first
  end
end
