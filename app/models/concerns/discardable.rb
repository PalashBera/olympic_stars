# frozen_string_literal: true

module Discardable
  extend ActiveSupport::Concern

  STATE_LIST = ["–", "deleted", "restored"].freeze

  included do
    validates :state, inclusion: { in: STATE_LIST }, allow_blank: true

    default_scope { where.not(state: "deleted") }
    scope :discarded, -> { where(state: "deleted") }
    scope :restored,  -> { where(state: "restored") }
  end

  def discard
    update(state: "deleted")
  end

  def restore
    update(state: "restored")
  end

  def discarded?
    state == "deleted"
  end

  def restored?
    state == "restored"
  end
end
