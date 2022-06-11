# frozen_string_literal: true

module Archivable
  extend ActiveSupport::Concern

  included do
    validates :archived, inclusion: { in: [true, false] }

    scope :archived,     -> { where(archived: true) }
    scope :non_archived, -> { where(archived: false) }
  end

  def non_archived?
    !archived?
  end

  def archived_status
    archived? ? I18n.t("status.archived") : I18n.t("status.active")
  end
end
