# frozen_string_literal: true

module Coaching
  class ClientTypesController < Coaching::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("client_types") }

    def index
      @search = current_account.client_types.ransack(params[:q])
      @pagy, @client_types = pagy(@search.result)
    end

    def show
      client_type
    end

    def new
      @client_type = current_account.client_types.new
    end

    def create
      @client_type = current_account.client_types.new(client_type_params)

      if @client_type.save
        redirect_to coaching_client_types_path, flash: { success: t("flash_messages.created", name: "Client type") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      client_type
    end

    def update
      if client_type.update(client_type_params)
        redirect_to coaching_client_types_path, flash: { success: t("flash_messages.updated", name: "Client type") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      client_type.destroy
      redirect_to coaching_client_types_path, flash: { danger: t("flash_messages.deleted", name: "Client type") }
    end

    private

    def client_type_params
      params.require(:client_type).permit(:name, :archived)
    end

    def client_type
      @client_type ||= current_account.client_types.find(params[:id])
    end
  end
end
