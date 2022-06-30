# frozen_string_literal: true

module Personal
  class TeacherPaymentsController < Personal::HomeController
    before_action { active_sidebar_sub_item_option("teachers") }

    def index
      @search = teacher.teacher_payments.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
      @pagy, @teacher_payments = pagy(@search.result.includes(included_resources))
    end

    def show
      teacher_payment
    end

    def new
      @teacher_payment = teacher.teacher_payments.new
    end

    def create
      @teacher_payment = teacher.teacher_payments.new(teacher_payment_params)

      if @teacher_payment.save
        redirect_to personal_teacher_teacher_payments_path(teacher),
                    flash: { success: t("flash_messages.created", name: "Payment") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      teacher_payment
    end

    def update
      if teacher_payment.update(teacher_payment_params)
        redirect_to personal_teacher_teacher_payments_path(teacher),
                    flash: { success: t("flash_messages.updated", name: "Payment") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def change_logs
      @versions = teacher_payment.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    private

    def teacher_payment_params
      params.require(:teacher_payment).permit(:date, :work_hours, :wage_per_hour, :discount, :details, :status,
                                              :payment_type_id, :payment_method_id)
    end

    def teacher
      @teacher ||= current_account.teachers.find(params[:teacher_id])
    end

    def teacher_payment
      @teacher_payment ||= teacher.teacher_payments.find(params[:id])
    end

    def included_resources
      %i[payment_type payment_method]
    end
  end
end
