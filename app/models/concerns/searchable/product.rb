# frozen_string_literal: true

module Searchable
  module Product
    extend ActiveSupport::Concern

    included do
      include AlgoliaSearch

      algoliasearch per_environment: true, disable_indexing: Rails.env.test? do
        attribute :id, :name, :sku, :account_id
        searchableAttributes %w[name sku]
        ranking %w[exact typo words filters proximity attribute custom]
      end
    end
  end
end
