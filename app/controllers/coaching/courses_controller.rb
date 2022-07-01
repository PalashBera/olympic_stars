# frozen_string_literal: true

module Coaching
  class CoursesController < Coaching::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("courses") }
    before_action :set_search_object, only: %i[index export]

    def index
      @pagy, @courses = pagy(@search.result.includes(included_resources))
    end

    def show
      course
    end

    def new
      @course = current_account.courses.new
    end

    def create
      @course = current_account.courses.new(course_params)

      if @course.save
        redirect_to coaching_courses_path, flash: { success: t("flash_messages.created", name: "Course") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      course
    end

    def update
      if course.update(course_params)
        redirect_to coaching_courses_path, flash: { success: t("flash_messages.updated", name: "Course") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      course.destroy
      redirect_to coaching_courses_path,
                  status: :see_other,
                  flash: { danger: t("flash_messages.deleted", name: "Course") }
    end

    def export
      @courses = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=courses.xlsx"
        end
      end
    end

    private

    def course_params
      params.require(:course).permit(:name, :fee, :archived)
    end

    def course
      @course ||= current_account.courses.find(params[:id])
    end

    def set_search_object
      @search = current_account.courses.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
    end

    def included_resources
      %i[students]
    end

    def export_included_resources
      included_resources << :created_by << :updated_by
    end
  end
end
