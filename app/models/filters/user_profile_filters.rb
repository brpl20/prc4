# frozen_string_literal: true

# Filtros para users
class UserProfileFilters
  class << self
    def by_role(role)
      UserProfile.where(role: role).order(:name)
    end
  end
end
