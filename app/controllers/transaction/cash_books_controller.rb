# frozen_string_literal: true

module Transaction
  class CashBooksController < Transaction::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("cash_books") }
    before_action :set_search_object, only: %i[index export]

    def index
      @pagy, @cash_books = pagy(@search.result)
    end

    def show
      cash_book
    end

    def new
      @cash_book = current_account.cash_books.new
    end

    def create
      @cash_book = current_account.cash_books.new(cash_books_params)

      if @cash_book.save
        redirect_to transaction_cash_books_path,
                    flash: { success: t("flash_messages.created", name: "Cash book") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      cash_book
    end

    def update
      if cash_book.update(cash_books_params)
        redirect_to transaction_cash_books_path,
                    flash: { success: t("flash_messages.updated", name: "Cash book") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      cash_book.destroy
      redirect_to transaction_cash_books_path, status: :see_other,
                                               flash: { danger: t("flash_messages.deleted", name: "Cash book") }
    end

    def export
      @cash_books = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=cash_books.xlsx"
        end
      end
    end

    private

    def cash_books_params
      params.require(:cash_book).permit(:date, :cash_amount, :card_amount, :withdrawn_amount, :leftover_amount)
    end

    def cash_book
      @cash_book ||= current_account.cash_books.find(params[:id])
    end

    def set_search_object
      @search = current_account.cash_books.ransack(params[:q])
      @search.sorts = "date desc" if @search.sorts.empty?
    end

    def included_resources
      []
    end

    def export_included_resources
      included_resources << :created_by << :updated_by
    end
  end
end
