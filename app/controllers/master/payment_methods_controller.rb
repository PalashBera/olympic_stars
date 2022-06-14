# frozen_string_literal: true

module Master
  class PaymentMethodsController < Master::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("payment_methods") }

    def index
      @search = current_account.payment_methods.ransack(params[:q])
      @pagy, @payment_methods = pagy(@search.result)
    end

    def new
      @payment_method = current_account.payment_methods.new
    end

    def create
      @payment_method = current_account.payment_methods.new(payment_methods_params)

      if @payment_method.save
        redirect_to master_payment_methods_path, flash: { success: t("flash_messages.created", name: "Payment method") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      payment_method
    end

    def update
      if payment_method.update(payment_methods_params)
        redirect_to master_payment_methods_path, flash: { success: t("flash_messages.updated", name: "Payment method") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      payment_method.destroy
      redirect_to master_payment_methods_path, flash: { danger: t("flash_messages.deleted", name: "Payment method") }
    end

    private

    def payment_methods_params
      params.require(:payment_method).permit(:name, :archived)
    end

    def payment_method
      @payment_method ||= current_account.payment_methods.find(params[:id])
    end
  end
end
