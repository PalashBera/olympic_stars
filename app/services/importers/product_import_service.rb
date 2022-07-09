# frozen_string_literal: true

require "csv"

module Importers
  class ProductImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        product = assign_product(row.to_hash)
        errors << [error_data_set(row) << product.full_error_message].flatten unless product.save
      end

      finish_import_process(@current_user, "Products")
    end

    def error_csv_header
      %w[name price sku error_message]
    end

    private

    def assign_product(row)
      @current_account.products.new(name: row["name"], price: row["price"], sku: row["sku"])
    end

    def error_data_set(row)
      [row["name"], row["price"], row["sku"]]
    end
  end
end
