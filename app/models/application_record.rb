# frozen_string_literal: true

require "string"

class ApplicationRecord < ActiveRecord::Base
  VALID_DECIMAL_REGEX = /\A\d+(?:\.\d{0,2})?\z/

  primary_abstract_class

  def class_title
    self.class.name.underscore.display
  end

  def button_name
    new_record? ? "Create" : "Update"
  end
end
