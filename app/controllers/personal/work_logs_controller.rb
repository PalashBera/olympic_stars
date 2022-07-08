# frozen_string_literal: true

module Personal
  class WorkLogsController < Personal::HomeController
    before_action { active_sidebar_sub_item_option("teachers") }
    before_action :set_search_object, only: %i[index export]

    def index
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
      redirect_to personal_teacher_work_logs_path, status: :see_other,
                                                   flash: { danger: t("flash_messages.deleted", name: "Work log") }
    end

    def change_logs
      @versions = work_log.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    def export
      @work_logs = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=work_logs.xlsx"
        end
      end
    end

    def import
      ::Importers::WorkLogImportService.call(params[:file], current_account, current_user, teacher)
      redirect_to personal_teacher_work_logs_path(teacher),
                  flash: { success: t("flash_messages.imported", name: "Work logs") }
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

    def set_search_object
      @search = teacher.work_logs.ransack(params[:q])
      @search.sorts = "date desc" if @search.sorts.empty?
    end

    def included_resources
      [:created_by]
    end

    def export_included_resources
      included_resources + [:updated_by]
    end
  end
end
