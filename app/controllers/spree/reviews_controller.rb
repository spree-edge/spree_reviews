module Spree
  class ReviewsController < Spree::StoreController
    helper Spree::BaseHelper
    helper Spree::ProgressBarHelper
    before_action :load_product, only: [:index, :new, :create]
    before_action :init_pagination, only: [:index]
    before_action :review_setting, only: [:index, :new, :create]

    def index
      @approved_reviews = Spree::Review.default_approval_filter(@review_setting)
                          .where(product: @product, store: @product.store_ids)
                          .page(@pagination_page)
                          .per(@pagination_per_page)

      @title = "#{@product.name} #{Spree.t(:reviews)}"

      @review = Spree::Review.new(product: @product)
      authorize! :create, @review
    end

    def new
      @review = Spree::Review.new(product: @product)
      authorize! :create, @review
    end

    def create
      params[:review][:rating].sub!(/\s*[^0-9]*\z/, '') unless params[:review][:rating].blank?

      @review = Spree::Review.new(review_params)
      @review.product = @product
      @review.user = spree_current_user if spree_user_signed_in?
      @review.ip_address = request.remote_ip
      @review.locale = I18n.locale.to_s if @review_setting&.track_locale
      @review.store = current_store
      @review.review_setting = current_store.review_setting || Spree::ReviewSetting.create!(store: current_store)

      authorize! :create, @review
      if @review.save
        flash[:notice] = Spree.t(:review_successfully_submitted)
        redirect_to spree.product_path(@product)
      else
        render :new
      end
    end

    private

    def load_product
      @product = Spree::Product.friendly.find(params[:product_id])
    end

    def permitted_review_attributes
      permitted_attributes.review_attributes
    end

    def review_params
      params.require(:review).permit(permitted_review_attributes)
    end

    def init_pagination
      @review_setting = current_store.review_setting
      @pagination_page = params[:page].present? ? params[:page].to_i : 1
      @pagination_per_page = params[:per_page].present? ? params[:per_page].to_i : @review_setting&.paginate_size
    end

    def review_setting
      @review_setting = current_store.review_setting
    end
  end
end
