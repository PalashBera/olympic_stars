# frozen_string_literal: true

module Inventory
  class ProductsController < Inventory::HomeController
    include ChangeLogable

    before_action { active_sidebar_sub_item_option("products") }
    before_action :set_search_object, only: %i[index export]

    def index
      @pagy, @products = pagy(@search.result)
    end

    def show
      product
    end

    def new
      @product = current_account.products.new
    end

    def create
      @product = current_account.products.new(product_params)

      if @product.save
        redirect_to inventory_products_path, flash: { success: t("flash_messages.created", name: "Product") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def edit
      product
    end

    def update
      if product.update(product_params)
        redirect_to inventory_products_path, flash: { success: t("flash_messages.updated", name: "Product") }
      else
        render :form_update, status: :unprocessable_entity
      end
    end

    def destroy
      product.destroy
      redirect_to inventory_products_path,
                  status: :see_other,
                  flash: { danger: t("flash_messages.deleted", name: "Product") }
    end

    def export
      @products = @search.result.includes(export_included_resources)

      respond_to do |format|
        format.xlsx do
          response.headers["Content-Disposition"] = "attachment; filename=products.xlsx"
        end
      end
    end

    private

    def product_params
      params.require(:product).permit(:name, :sku, :price, :archived)
    end

    def product
      @product ||= current_account.products.find(params[:id])
    end

    def set_search_object
      @search = current_account.products.ransack(params[:q])
      @search.sorts = "id desc" if @search.sorts.empty?
    end

    def export_included_resources
      %i[created_by updated_by]
    end
  end
end
