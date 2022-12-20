class Power < ApplicationRecord
  has_and_belongs_to_many :works

  class PowerFilters
    class << self
      def by_cat(category)
        Power.where(category: category).order(:category)
      end
    end
  end

end
