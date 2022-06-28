# frozen_string_literal: true

module Coaching
  class PaymentsController < Coaching::HomeController
    before_action { active_sidebar_sub_item_option("students") }

    def index
      @search = student.payments.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @payments = pagy(@search.result.includes(included_resources))
    end

    def show
      payment
    end

    def new
      @payment = student.payments.new
    end

    def create
      @payment = student.payments.new(payment_params)

      if @payment.save
        redirect_to coaching_student_payments_path(student),
                    flash: { success: t("flash_messages.created", name: "Payment") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      payment
    end

    def update
      if payment.update(payment_params)
        redirect_to coaching_student_payments_path(student),
                    flash: { success: t("flash_messages.updated", name: "Payment") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def change_logs
      @versions = payment.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    private

    def payment_params
      params.require(:payment).permit(:date, :amount, :discount, :details, :status, :payment_type_id,
                                      :payment_method_id)
    end

    def student
      @student ||= current_account.students.find(params[:student_id])
    end

    def payment
      @payment ||= student.payments.find(params[:id])
    end

    def included_resources
      %i[payment_type payment_method]
    end
  end
end
