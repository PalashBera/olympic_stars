# frozen_string_literal: true

require "csv"

module Importers
  class PaymentTypeImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        payment_type = assign_payment_type(row.to_hash)
        errors << [error_data_set(row) << payment_type.full_error_message].flatten unless payment_type.save
      end

      finish_import_process(@current_user, "Payment Types")
    end

    def error_csv_header
      %w[name category error_message]
    end

    private

    def assign_payment_type(row)
      @current_account.payment_types.new(name: row["name"], category: row["category"].to_s.downcase)
    end

    def error_data_set(row)
      [row["name"], row["category"]]
    end
  end
end
