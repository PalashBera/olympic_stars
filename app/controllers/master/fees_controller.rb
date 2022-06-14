# frozen_string_literal: true

module Master
  class FeesController < Master::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("fees") }

    def index
      @search = current_account.fees.ransack(params[:q])
      @pagy, @fees = pagy(@search.result)
    end

    def new
      @fee = current_account.fees.new
    end

    def create
      @fee = current_account.fees.new(fee_params)

      if @fee.save
        redirect_to master_fees_path, flash: { success: t("flash_messages.created", name: "Fee") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      fee
    end

    def update
      if fee.update(fee_params)
        redirect_to master_fees_path, flash: { success: t("flash_messages.updated", name: "Fee") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      fee.destroy
      redirect_to master_fees_path, flash: { danger: t("flash_messages.deleted", name: "Fee") }
    end

    private

    def fee_params
      params.require(:fee).permit(:name, :amount, :archived)
    end

    def fee
      @fee ||= current_account.fees.find(params[:id])
    end
  end
end
