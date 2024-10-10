module Spree
  module ProductsControllerDecorator
    def self.prepended(base)
      base.helper Spree::ReviewsHelper
      base.before_action :review_setting
    end

    private
    def review_setting
      @review_setting = current_store.review_setting
    end
  end
end

::Spree::ProductsController.prepend Spree::ProductsControllerDecorator
