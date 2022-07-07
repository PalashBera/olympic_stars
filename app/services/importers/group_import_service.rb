# frozen_string_literal: true

require "csv"

module Importers
  class GroupImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        group = assign_group(row.to_hash)
        errors << [error_data_set(row) << group.full_error_message].flatten unless group.save
      end

      finish_import_process(@current_user, "Groups")
    end

    def error_csv_header
      %w[name quota start_time end_time teacher_email client_type monday
         tuesday wednesday thursday friday saturday error_message]
    end

    private

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def assign_group(row)
      @current_account.groups.new(
        name: row["name"],
        quota: row["quota"],
        start_time: row["start_time"],
        end_time: row["end_time"],
        teacher: find_teacher(row["teacher_email"].to_s.strip),
        client_type: find_client_type(row["client_type"].to_s.strip),
        monday: get_day(row["monday"].to_s.strip),
        tuesday: get_day(row["tuesday"].to_s.strip),
        wednesday: get_day(row["wednesday"].to_s.strip),
        thursday: get_day(row["thursday"].to_s.strip),
        friday: get_day(row["friday"].to_s.strip),
        saturday: get_day(row["saturday"].to_s.strip)
      )
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def error_data_set(row)
      [row["name"], row["quota"], row["start_time"], row["end_time"], row["teacher_email"], row["client_type"],
       row["monday"], row["tuesday"], row["wednesday"], row["thursday"], row["friday"], row["saturday"]]
    end

    def find_teacher(teacher_email)
      @current_account.teachers.find_by(email: teacher_email)
    end

    def find_client_type(client_type_name)
      @current_account.client_types.find_by(name: client_type_name)
    end

    def get_day(value)
      value.downcase == "yes"
    end
  end
end
