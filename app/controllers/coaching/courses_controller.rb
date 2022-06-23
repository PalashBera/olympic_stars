# frozen_string_literal: true

module Coaching
  class CoursesController < Coaching::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("courses") }

    def index
      @search = current_account.courses.ransack(params[:q])
      @pagy, @courses = pagy(@search.result)
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
      redirect_to coaching_courses_path, flash: { danger: t("flash_messages.deleted", name: "Course") }
    end

    private

    def course_params
      params.require(:course).permit(:name, :amount, :archived)
    end

    def course
      @course ||= current_account.courses.find(params[:id])
    end
  end
end
