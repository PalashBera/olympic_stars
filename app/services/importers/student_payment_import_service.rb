# frozen_string_literal: true

require "csv"

module Importers
  class StudentPaymentImportService < Importers::ImportService
    def initialize(imported_file, current_account, current_user, student)
      @imported_file = imported_file
      @current_account = current_account
      @current_user = current_user
      @student = student
    end

    def call
      CSV.foreach(@imported_file, headers: true).map do |row|
        student_payment = assign_student_payment(row.to_hash)
        errors << [error_data_set(row) << student_payment.full_error_message].flatten unless student_payment.save
      end

      finish_import_process(@current_user, "Student Payments")
    end

    def error_csv_header
      %w[date payment_type amount discount payment_method details status]
    end

    private

    def assign_student_payment(row)
      @student.student_payments.new(
        date: row["date"],
        payment_type: find_payment_type(row["payment_type"].to_s.strip),
        amount: row["amount"],
        discount: row["discount"],
        payment_method: find_payment_method(row["payment_method"].to_s.strip),
        details: row["details"],
        status: row["status"].to_s.downcase
      )
    end

    def error_data_set(row)
      [row["date"], row["payment_type"], row["amount"], row["discount"],
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
