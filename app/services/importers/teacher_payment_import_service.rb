# frozen_string_literal: true

require "csv"

module Importers
  class TeacherPaymentImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user, teacher)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
      @teacher = teacher
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        teacher_payment = assign_teacher_payment(row.to_hash)
        errors << [error_data_set(row) << teacher_payment.full_error_message].flatten unless teacher_payment.save
      end

      finish_import_process(@current_user, "Teacher Payments")
    end

    def error_csv_header
      %w[date payment_type work_hours wage_per_hour discount payment_method details status]
    end

    private

    # rubocop:disable Metrics/AbcSize
    def assign_teacher_payment(row)
      @teacher.teacher_payments.new(
        date: row["date"],
        payment_type: find_payment_type(row["payment_type"].to_s.strip),
        work_hours: row["work_hours"],
        wage_per_hour: row["wage_per_hour"],
        discount: row["discount"],
        payment_method: find_payment_method(row["payment_method"].to_s.strip),
        details: row["details"],
        status: row["status"].to_s.downcase
      )
    end
    # rubocop:enable Metrics/AbcSize

    def error_data_set(row)
      [row["date"], row["payment_type"], row["work_hours"], row["wage_per_hour"], row["discount"],
       row["payment_method"], row["details"], row["status"]]
    end

    def find_payment_type(payment_type)
      @current_account.payment_types.find_by(name: payment_type)
    end

    def find_payment_method(payment_method)
      @current_account.payment_methods.find_by(name: payment_method)
    end
  end
end
