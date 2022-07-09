# frozen_string_literal: true

module Searchable
  module Teacher
    extend ActiveSupport::Concern

    included do
      include AlgoliaSearch

      algoliasearch per_environment: true, disable_indexing: Rails.env.test? do
        attribute :id, :first_name, :last_name, :email, :account_id
        searchableAttributes %w[first_name last_name email]
        ranking %w[exact typo words filters proximity attribute custom]
      end
    end
  end
end
