# frozen_string_literal: true

require "string"
require "true_class"
require "false_class"

class ApplicationRecord < ActiveRecord::Base
  VALID_DECIMAL_REGEX = /\A\d+(?:\.\d{0,2})?\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  primary_abstract_class

  def class_title
    self.class.name.underscore.display
  end

  def button_name
    new_record? ? "Create" : "Update"
  end

  def full_error_message
    errors.full_messages.join(", ")
  end
end
