# frozen_string_literal: true

require "csv"

module Importers
  class ImportService < ApplicationService
    def errors
      @errors ||= []
    end

    def error_csv
      CSV.generate(headers: true) do |csv|
        csv << error_csv_header
        errors.each { |row| csv << row }
      end
    end

    def finish_import_process(user, module_name)
      if errors.present?
        ImportMailer.failure(user, module_name, error_csv).deliver_now
      else
        ImportMailer.success(user, module_name).deliver_now
      end
    end
  end
end
