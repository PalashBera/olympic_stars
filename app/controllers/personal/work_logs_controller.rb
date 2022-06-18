# frozen_string_literal: true

module Personal
  class WorkLogsController < Personal::HomeController
    before_action { active_sidebar_sub_item_option("work_logs") }

    def index
      @search = teacher.work_logs.ransack(params[:q])
      @pagy, @work_logs = pagy(@search.result.includes(included_resources))
    end

    def new
      @work_log = teacher.work_logs.new
    end

    def create
      @work_log = teacher.work_logs.new(work_log_params)

      if @work_log.save
        redirect_to personal_teacher_work_logs_path, flash: { success: t("flash_messages.created", name: "Work log") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      work_log
    end

    def update
      if work_log.update(work_log_params)
        redirect_to personal_teacher_work_logs_path, flash: { success: t("flash_messages.updated", name: "Work log") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      work_log.destroy
      redirect_to personal_teacher_work_logs_path, flash: { danger: t("flash_messages.deleted", name: "Work log") }
    end

    def change_logs
      @work_log = teacher.work_logs.find(params[:id])
      @versions = @work_log.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    private

    def work_log_params
      params.require(:work_log).permit(:date, :hours, :teacher_id)
    end

    def teacher
      @teacher ||= current_account.teachers.find(params[:teacher_id])
    end

    def work_log
      @work_log ||= teacher.work_logs.find(params[:id])
    end

    def included_resources
      %i[created_by]
    end
  end
end
