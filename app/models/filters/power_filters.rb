# frozen_string_literal: true

# Filtros para users
class PowerFilters
  class << self
    def by_cat(category)
      Power.where(category: category).order(:category)
    end
  end
end
