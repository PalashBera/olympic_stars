# frozen_string_literal: true

module Master
  class PaymentTypesController < Master::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("payment_types") }

    def index
      @search = current_account.payment_types.ransack(params[:q])
      @pagy, @payment_types = pagy(@search.result)
    end

    def new
      @payment_type = current_account.payment_types.new
    end

    def create
      @payment_type = current_account.payment_types.new(payment_type_params)

      if @payment_type.save
        redirect_to master_payment_types_path, flash: { success: t("flash_messages.created", name: "Payment type") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      payment_type
    end

    def update
      if payment_type.update(payment_type_params)
        redirect_to master_payment_types_path, flash: { success: t("flash_messages.updated", name: "Payment type") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      payment_type.destroy
      redirect_to master_payment_types_path, flash: { danger: t("flash_messages.deleted", name: "Payment type") }
    end

    private

    def payment_type_params
      params.require(:payment_type).permit(:name, :archived)
    end

    def payment_type
      @payment_type ||= current_account.payment_types.find(params[:id])
    end
  end
end
