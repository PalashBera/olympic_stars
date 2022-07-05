# frozen_string_literal: true

module Coaching
  class GroupsController < Coaching::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("groups") }
    before_action :set_search_object, only: %i[index export]

    def index
      @pagy, @groups = pagy(@search.result.includes(included_resources))
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
        redirect_to coaching_group_path(@group), flash: { success: t("flash_messages.created", name: "Group") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      group
    end

    def update
      if group.update(group_params)
        redirect_to coaching_group_path(group), flash: { success: t("flash_messages.updated", name: "Group") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      group.destroy
      redirect_to coaching_groups_path, status: :see_other,
                                        flash: { danger: t("flash_messages.deleted", name: "Group") }
    end

    def export
      @groups = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=groups.xlsx"
        end
      end
    end

    private

    def group_params
      params.require(:group).permit(:name, :quota, :start_time, :end_time, :archived, :monday, :tuesday, :wednesday,
                                    :thursday, :friday, :saturday, :client_type_id, :teacher_id)
    end

    def group
      @group ||= current_account.groups.find(params[:id])
    end

    def set_search_object
      @search = current_account.groups.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
    end

    def included_resources
      %i[teacher client_type subscribers]
    end

    def export_included_resources
      included_resources + %i[last_attendance created_by updated_by]
    end
  end
end
