# frozen_string_literal: true

module Master
  class HomeController < ApplicationController
    before_action :authenticate_user!
    before_action { active_sidebar_item_option("master") }
  end
end
