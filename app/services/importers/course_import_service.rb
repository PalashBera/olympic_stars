# frozen_string_literal: true

require "csv"

module Importers
  class CourseImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        course = assign_course(row.to_hash)
        errors << [error_data_set(row) << course.full_error_message].flatten unless course.save
      end

      finish_import_process(@current_user, "Courses")
    end

    def error_csv_header
      %w[name fee error_message]
    end

    private

    def assign_course(row)
      @current_account.courses.new(name: row["name"], fee: row["fee"])
    end

    def error_data_set(row)
      [row["name"], row["fee"]]
    end
  end
end
