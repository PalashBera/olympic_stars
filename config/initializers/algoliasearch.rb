# frozen_string_literal: true

AlgoliaSearch.configuration = {
  application_id: ENV.fetch("ALGOLIA_APPLICATION_ID", nil),
  api_key: ENV.fetch("ALGOLIA_API_KEY", nil),
  connect_timeout: 2,
  receive_timeout: 30,
  send_timeout: 30,
  batch_timeout: 120,
  search_timeout: 30
}
