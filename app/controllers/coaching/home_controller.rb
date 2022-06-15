# frozen_string_literal: true

module Coaching
  class HomeController < ApplicationController
    before_action :authenticate_user!
    before_action { active_sidebar_item_option("coaching") }
  end
end
