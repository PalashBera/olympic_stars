# frozen_string_literal: true

module Transaction
  class IncomesController < Transaction::HomeController
    before_action { active_sidebar_sub_item_option("incomes") }

    def index
      @search = Income.ransack(params[:q])
      @search.sorts = "date desc" if @search.sorts.empty?
      @incomes = @search.result.includes(included_resources)
    end

    def change_logs
      @income = Income.find(params[:id])
      @versions = @income.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    private

    def included_resources
      [{ income_resourcable: %i[payment_method payment_type student teacher] }]
    end
  end
end
