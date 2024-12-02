module Spree
  class ReviewSetting < ApplicationRecord
    belongs_to :store
    has_many :reviews

    def self.stars
      5
    end
  end
end
