# frozen_string_literal: true

module ChangeLogable
  extend ActiveSupport::Concern

  def change_logs
    @resource = current_account.public_send(controller_name).find(params[:id])
    @versions = @resource.versions.includes(:item).reverse
    render "shared/change_logs"
  end
end
