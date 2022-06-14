# frozen_string_literal: true

module Personal
  class HomeController < ApplicationController
    before_action :authenticate_user!
    before_action { active_sidebar_item_option("personal") }
  end
end
