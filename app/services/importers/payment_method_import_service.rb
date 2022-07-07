# frozen_string_literal: true

require "csv"

module Importers
  class PaymentMethodImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        payment_method = assign_payment_method(row.to_hash)
        errors << [error_data_set(row) << payment_method.full_error_message].flatten unless payment_method.save
      end

      finish_import_process(@current_user, "Payment Methods")
    end

    def error_csv_header
      %w[name error_message]
    end

    private

    def assign_payment_method(row)
      @current_account.payment_methods.new(name: row["name"])
    end

    def error_data_set(row)
      [row["name"]]
    end
  end
end
