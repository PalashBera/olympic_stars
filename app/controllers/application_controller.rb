# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :resolve_layout

  include Pagy::Backend
  include SessionsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit, :set_current_user, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  def active_sidebar_item_option(option)
    @active_sidebar_item = option
  end

  def active_sidebar_sub_item_option(option)
    @active_sidebar_sub_item = option
  end

  def user_for_paper_trail
    current_user&.full_name.presence || "System User"
  end

  private

  def set_current_user
    User.current_user = current_user
  end

  def resolve_layout
    if user_signed_in?
      "application"
    else
      "basic"
    end
  end
end
