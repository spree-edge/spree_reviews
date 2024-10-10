module SpreeReviews
  module StoreDecorator
    def self.prepended(base)
      base.has_many :reviews, class_name: 'Spree::Review', foreign_key: 'store_id'
      base.has_one :review_setting
    end

  end
end

::Spree::Store.prepend SpreeReviews::StoreDecorator
