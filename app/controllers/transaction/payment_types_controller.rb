# frozen_string_literal: true

module Transaction
  class PaymentTypesController < Transaction::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("payment_types") }
    before_action :set_search_object, only: %i[index export]

    def index
      @pagy, @payment_types = pagy(@search.result.includes(included_resources))
    end

    def show
      payment_type
    end

    def new
      @payment_type = current_account.payment_types.new
    end

    def create
      @payment_type = current_account.payment_types.new(payment_type_params)

      if @payment_type.save
        redirect_to transaction_payment_types_path,
                    flash: { success: t("flash_messages.created", name: "Payment type") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      payment_type
    end

    def update
      if payment_type.update(payment_type_params)
        redirect_to transaction_payment_types_path,
                    flash: { success: t("flash_messages.updated", name: "Payment type") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      payment_type.destroy
      redirect_to transaction_payment_types_path, status: :see_other,
                                                  flash: { danger: t("flash_messages.deleted", name: "Payment type") }
    end

    def export
      @payment_types = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=payment_types.xlsx"
        end
      end
    end

    private

    def payment_type_params
      params.require(:payment_type).permit(:name, :category, :archived)
    end

    def payment_type
      @payment_type ||= current_account.payment_types.find(params[:id])
    end

    def set_search_object
      @search = current_account.payment_types.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
    end

    def included_resources
      %i[student_payments teacher_payments]
    end

    def export_included_resources
      included_resources + %i[created_by updated_by]
    end
  end
end
