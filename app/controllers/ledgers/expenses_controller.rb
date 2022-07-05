# frozen_string_literal: true

module Ledgers
  class ExpensesController < Ledgers::HomeController
    before_action { active_sidebar_sub_item_option("expenses") }
    before_action :set_search_object, only: %i[index export]

    def index
      @expenses = @search.result.includes(included_resources)
    end

    def change_logs
      @expense = Expense.find(params[:id])
      @versions = @expense.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    def export
      @expenses = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=expenses_ledger.xlsx"
        end
      end
    end

    private

    def set_search_object
      @search = Expense.ransack(params[:q])
      @search.sorts = "date desc" if @search.sorts.empty?
    end

    def included_resources
      [{ expense_resourcable: %i[payment_method payment_type student teacher] }]
    end

    def export_included_resources
      included_resources + %i[created_by updated_by]
    end
  end
end
