# frozen_string_literal: true

module Personal
  class TeachersController < Personal::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("teachers") }
    before_action :set_search_object, only: %i[index export]

    def index
      @pagy, @teachers = pagy(@search.result)
    end

    def show
      teacher
    end

    def new
      @teacher = current_account.teachers.new
    end

    def create
      @teacher = current_account.teachers.new(teacher_params)

      if @teacher.save
        redirect_to personal_teacher_path(@teacher), flash: { success: t("flash_messages.created", name: "Teacher") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      teacher
    end

    def update
      if teacher.update(teacher_params)
        redirect_to personal_teacher_path(teacher), flash: { success: t("flash_messages.updated", name: "Teacher") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      teacher.destroy
      redirect_to personal_teachers_path, status: :see_other,
                                          flash: { danger: t("flash_messages.deleted", name: "Teacher") }
    end

    def export
      @teachers = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=teachers.xlsx"
        end
      end
    end

    private

    def teacher_params
      params.require(:teacher).permit(:first_name, :last_name, :email, :availability, :phone_number, :mobile_number,
                                      :wages_per_day, :wages_per_month, :wages_per_hour, :date_of_birth, :archived)
    end

    def teacher
      @teacher ||= current_account.teachers.find(params[:id])
    end

    def set_search_object
      @search = current_account.teachers.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
    end

    def export_included_resources
      %i[created_by updated_by]
    end
  end
end
