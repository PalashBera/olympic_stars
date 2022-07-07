# frozen_string_literal: true

require "csv"

module Importers
  class StudentImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        student = assign_student(row.to_hash)
        errors << [error_data_set(row) << student.full_error_message].flatten unless student.save
      end

      finish_import_process(@current_user, "Students")
    end

    def error_csv_header
      %w[first_name last_name student_code date_of_birth school_name allergies registration_date
         client_type course mother_name mother_email mother_phone_number father_name father_email
         father_phone_number address remarks facebook pro_client error_message]
    end

    private

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def assign_student(row)
      @current_account.students.new(
        first_name: row["first_name"],
        last_name: row["last_name"],
        student_code: row["student_code"],
        date_of_birth: row["date_of_birth"],
        school_name: row["school_name"],
        allergies: row["allergies"],
        registration_date: row["registration_date"],
        client_type: find_client_type(row["client_type"].to_s.strip),
        course: find_course(row["course"].to_s.strip),
        mother_name: row["mother_name"],
        mother_email: row["mother_email"],
        mother_phone_number: row["mother_phone_number"],
        father_name: row["father_name"],
        father_email: row["father_email"],
        father_phone_number: row["father_phone_number"],
        address: row["address"],
        remarks: row["remarks"],
        facebook: get_boolean(row["facebook"].to_s.strip),
        pro_client: get_boolean(row["pro_client"].to_s.strip)
      )
    end
    # rubocop:enable Metrics/MethodLength

    def error_data_set(row)
      [row["first_name"], row["last_name"], row["student_code"], row["date_of_birth"], row["school_name"],
       row["allergies"], row["registration_date"], row["client_type"], row["course"], row["mother_name"],
       row["mother_email"], row["mother_phone_number"], row["father_name"], row["father_email"],
       row["father_phone_number"], row["address"], row["remarks"], row["facebook"], row["pro_client"]]
    end
    # rubocop:enable Metrics/AbcSize

    def find_client_type(client_type_name)
      @current_account.client_types.find_by(name: client_type_name)
    end

    def find_course(course_name)
      @current_account.courses.find_by(name: course_name)
    end

    def get_boolean(value)
      value.downcase == "yes"
    end
  end
end
