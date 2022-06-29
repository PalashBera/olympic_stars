# frozen_string_literal: true

module Transaction
  class ExpensesController < Transaction::HomeController
    before_action { active_sidebar_sub_item_option("expenses") }

    def index
      @search = Expense.ransack(params[:q])
      @search.sorts = "date desc" if @search.sorts.empty?
      @expenses = @search.result.includes(included_resources)
    end

    def change_logs
      @expense = Expense.find(params[:id])
      @versions = @expense.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    private

    def included_resources
      [{ expense_resourcable: %i[payment_method payment_type] }, :created_by, :updated_by]
    end
  end
end
