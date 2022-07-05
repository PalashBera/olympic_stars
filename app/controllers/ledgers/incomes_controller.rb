# frozen_string_literal: true

module Ledgers
  class IncomesController < Ledgers::HomeController
    before_action { active_sidebar_sub_item_option("incomes") }
    before_action :set_search_object, only: %i[index export]

    def index
      @incomes = @search.result.includes(included_resources)
    end

    def change_logs
      @income = Income.find(params[:id])
      @versions = @income.versions.includes(:item).reverse
      render "shared/change_logs"
    end

    def export
      @incomes = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=incomes_ledger.xlsx"
        end
      end
    end

    private

    def set_search_object
      @search = Income.ransack(params[:q])
      @search.sorts = "date desc" if @search.sorts.empty?
    end

    def included_resources
      [{ income_resourcable: %i[payment_method payment_type student teacher] }]
    end

    def export_included_resources
      included_resources + %i[created_by updated_by]
    end
  end
end
