# frozen_string_literal: true

require "csv"

module Importers
  class TeacherImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        teacher = assign_teacher(row.to_hash)
        errors << [error_data_set(row) << teacher.full_error_message].flatten unless teacher.save
      end

      finish_import_process(@current_user, "Teachers")
    end

    def error_csv_header
      %w[first_name last_name email date_of_birth phone_number mobile_number wages_per_hour wages_per_day
         wages_per_month availability error_message]
    end

    private

    # rubocop:disable Metrics/MethodLength
    def assign_teacher(row)
      @current_account.teachers.new(
        first_name: row["first_name"],
        last_name: row["last_name"],
        email: row["email"],
        date_of_birth: row["date_of_birth"],
        phone_number: row["phone_number"],
        mobile_number: row["mobile_number"],
        wages_per_hour: row["wages_per_hour"],
        wages_per_day: row["wages_per_day"],
        wages_per_month: row["wages_per_month"],
        availability: row["availability"]
      )
    end
    # rubocop:enable Metrics/MethodLength

    def error_data_set(row)
      [row["first_name"], row["last_name"], row["email"], row["date_of_birth"], row["phone_number"],
       row["mobile_number"], row["wages_per_hour"], row["wages_per_day"], row["wages_per_month"], row["availability"]]
    end
  end
end
