# frozen_string_literal: true

module Coaching
  class StudentPaymentsController < Coaching::HomeController
    before_action { active_sidebar_sub_item_option("students") }

    def index
      @search = student.student_payments.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @student_payments = pagy(@search.result.includes(included_resources))
    end

    def show
      student_payment
    end

    def new
      @student_payment = student.student_payments.new
    end

    def create
      @student_payment = student.student_payments.new(student_payment_params)

      if @student_payment.save
        redirect_to coaching_student_student_payments_path(student),
                    flash: { success: t("flash_messages.created", name: "Payment") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      student_payment
    end

    def update
      if student_payment.update(student_payment_params)
        redirect_to coaching_student_student_payments_path(student),
                    flash: { success: t("flash_messages.updated", name: "Payment") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def change_logs
      @versions = student_payment.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    private

    def student_payment_params
      params.require(:student_payment).permit(:date, :amount, :discount, :details, :status, :payment_type_id,
                                              :payment_method_id)
    end

    def student
      @student ||= current_account.students.find(params[:student_id])
    end

    def student_payment
      @student_payment ||= student.student_payments.find(params[:id])
    end

    def included_resources
      %i[payment_type payment_method]
    end
  end
end
