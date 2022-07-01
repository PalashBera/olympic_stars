# frozen_string_literal: true

module Ledgers
  class HomeController < ApplicationController
    before_action :authenticate_user!
    before_action { active_sidebar_item_option("ledgers") }
  end
end
