# frozen_string_literal: true

require "pagy/extras/i18n"
require "pagy/extras/array"

Pagy::DEFAULT[:items] = 15 # items per page
Pagy::DEFAULT[:size]  = [1, 4, 4, 1] # nav bar links
