# frozen_string_literal: true

class ImportMailer < ApplicationMailer
  def success(recipient, module_name)
    @recipient = recipient
    @module_name = module_name
    mail(to: @recipient.email, subject: I18n.t("email_subjects.data_import_success", module_name: @module_name))
  end

  def failure(recipient, module_name, error_string)
    @recipient = recipient
    @module_name = module_name
    attachments["error_records.csv"] = { mime_type: "text/csv", content: error_string }
    mail(to: @recipient.email, subject: I18n.t("email_subjects.data_import_failure", module_name: @module_name))
  end
end
