# frozen_string_literal: true

module Coaching
  class AttendancesController < Coaching::HomeController
    before_action { active_sidebar_sub_item_option("groups") }
    before_action :set_search_object, only: %i[index export]

    def index
      @attendances = @search.result
      @subscribers = group.subscribers.includes(included_resources).order_by_name
    end

    def create
      @attendance = group.attendances.new(attendance_params)

      if @attendance.save
        flash[:success] = t("flash_messages.created", name: "Attendance")
      else
        flash[:danger] = t("flash_messages.something_went_wrong")
      end

      redirect_to coaching_group_attendances_path(group)
    end

    def destroy
      attendance.destroy
      redirect_to coaching_group_attendances_path(group),
                  status: :see_other,
                  flash: { danger: t("flash_messages.deleted", name: "Attendance") }
    end

    def export
      @attendances = @search.result
      @subscribers = group.subscribers.includes(included_resources).order_by_name

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=attendances.xlsx"
        end
      end
    end

    private

    def attendance_params
      params.require(:attendance).permit(:subscriber_id, :date)
    end

    def group
      @group ||= current_account.groups.find(params[:group_id])
    end

    def attendance
      @attendance ||= group.attendances.find(params[:id])
    end

    def included_resources
      [:student]
    end

    def month
      @month ||= params[:month].presence || Date.current.month
    end

    def year
      @year ||= params[:year].presence || Date.current.year
    end

    def set_search_object
      @search = group.attendances.by_date_range(month, year).ransack(params[:q])
    end
  end
end
