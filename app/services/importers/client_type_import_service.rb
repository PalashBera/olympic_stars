# frozen_string_literal: true

require "csv"

module Importers
  class ClientTypeImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        client_type = assign_client_type(row.to_hash)
        errors << [error_data_set(row) << client_type.full_error_message].flatten unless client_type.save
      end

      finish_import_process(@current_user, "Client Types")
    end

    def error_csv_header
      %w[name error_message]
    end

    private

    def assign_client_type(row)
      @current_account.client_types.new(name: row["name"])
    end

    def error_data_set(row)
      [row["name"]]
    end
  end
end
