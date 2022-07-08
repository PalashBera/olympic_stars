# frozen_string_literal: true

require "csv"

module Importers
  class WorkLogImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user, teacher)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
      @teacher = teacher
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        work_log = assign_work_log(row.to_hash)
        errors << [error_data_set(row) << work_log.full_error_message].flatten unless work_log.save
      end

      finish_import_process(@current_user, "Work Logs")
    end

    def error_csv_header
      %w[date hours error_message]
    end

    private

    def assign_work_log(row)
      @teacher.work_logs.new(date: row["date"], hours: row["hours"])
    end

    def error_data_set(row)
      [row["date"], row["hours"]]
    end
  end
end
