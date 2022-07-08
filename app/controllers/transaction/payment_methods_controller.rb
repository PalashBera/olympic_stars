# frozen_string_literal: true

module Transaction
  class PaymentMethodsController < Transaction::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("payment_methods") }
    before_action :set_search_object, only: %i[index export]

    def index
      @pagy, @payment_methods = pagy(@search.result)
    end

    def show
      payment_method
    end

    def new
      @payment_method = current_account.payment_methods.new
    end

    def create
      @payment_method = current_account.payment_methods.new(payment_methods_params)

      if @payment_method.save
        redirect_to transaction_payment_methods_path,
                    flash: { success: t("flash_messages.created", name: "Payment method") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      payment_method
    end

    def update
      if payment_method.update(payment_methods_params)
        redirect_to transaction_payment_methods_path,
                    flash: { success: t("flash_messages.updated", name: "Payment method") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      payment_method.destroy
      redirect_to transaction_payment_methods_path,
                  status: :see_other,
                  flash: { danger: t("flash_messages.deleted", name: "Payment method") }
    end

    def export
      @payment_methods = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=payment_methods.xlsx"
        end
      end
    end

    def import
      ::Importers::PaymentMethodImportService.call(params[:file], current_account, current_user)
      redirect_to transaction_payment_methods_path,
                  flash: { success: t("flash_messages.imported", name: "Payment methods") }
    end

    private

    def payment_methods_params
      params.require(:payment_method).permit(:name, :archived)
    end

    def payment_method
      @payment_method ||= current_account.payment_methods.find(params[:id])
    end

    def set_search_object
      @search = current_account.payment_methods.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
    end

    def export_included_resources
      %i[created_by updated_by]
    end
  end
end
