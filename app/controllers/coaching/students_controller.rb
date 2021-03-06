# frozen_string_literal: true

module Coaching
  class StudentsController < Coaching::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("students") }
    before_action :set_search_object, only: %i[index export]

    def index
      @pagy, @students = pagy(@search.result.includes(included_resources))
    end

    def show
      student
    end

    def new
      @student = current_account.students.new
    end

    def create
      @student = current_account.students.new(student_params)

      if @student.save
        redirect_to coaching_student_path(@student), flash: { success: t("flash_messages.created", name: "Student") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      student
    end

    def update
      if student.update(student_params)
        redirect_to coaching_student_path(student), flash: { success: t("flash_messages.updated", name: "Student") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      student.destroy
      redirect_to coaching_students_path, status: :see_other,
                                          flash: { danger: t("flash_messages.deleted", name: "Student") }
    end

    def export
      @students = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=students.xlsx"
        end
      end
    end

    def import
      ::Importers::StudentImportService.call(params[:file], current_account, current_user)
      redirect_to coaching_students_path, flash: { success: t("flash_messages.imported", name: "Students") }
    end

    private

    def student_params
      params.require(:student).permit(:first_name, :last_name, :father_name, :mother_name, :father_email, :mother_email,
                                      :address, :father_phone_number, :mother_phone_number, :date_of_birth,
                                      :registration_date, :archived, :facebook, :pro_client, :remarks, :course_id,
                                      :client_type_id, :student_code, :allergies, :school_name)
    end

    def student
      @student ||= current_account.students.find(params[:id])
    end

    def set_search_object
      @search = current_account.students.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
    end

    def included_resources
      %i[course client_type group]
    end

    def export_included_resources
      included_resources + %i[last_attendance last_student_payment created_by updated_by]
    end
  end
end
