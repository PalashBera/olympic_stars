# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  default from: ENV.fetch("MAIL_SENDER", nil)
  layout "mailer"
end
