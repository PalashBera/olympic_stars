# frozen_string_literal: true

module Coaching
  class GroupsController < Coaching::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("groups") }

    def index
      @search = current_account.groups.ransack(params[:q])
      @pagy, @groups = pagy(@search.result)
    end

    def show
      group
    end

    def new
      @group = current_account.groups.new
    end

    def create
      @group = current_account.groups.new(group_params)

      if @group.save
        redirect_to coaching_groups_path, flash: { success: t("flash_messages.created", name: "Group") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      group
    end

    def update
      if group.update(group_params)
        redirect_to coaching_groups_path, flash: { success: t("flash_messages.updated", name: "Group") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      group.destroy
      redirect_to coaching_groups_path, flash: { danger: t("flash_messages.deleted", name: "Group") }
    end

    private

    def group_params
      params.require(:group).permit(:name, :quota, :start_time, :end_time, :archived, :monday, :tuesday, :wednesday,
                                    :thursday, :friday, :saturday, :client_type_id, :teacher_id)
    end

    def group
      @group ||= current_account.groups.find(params[:id])
    end
  end
end
