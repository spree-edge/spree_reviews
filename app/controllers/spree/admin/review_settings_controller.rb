module Spree
  module Admin
    class ReviewSettingsController < ResourceController
      before_action :find_review_settings, only: [:edit, :update]

      def edit
        unless @review_setting = current_store.review_setting
          @review_setting =  Spree::ReviewSetting.create!(store: current_store)
        end
      end

      def update
        @review_setting.update(review_setting_params)

        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:review_settings, scope: :spree_reviews))
        redirect_to edit_admin_review_settings_path
      end

      private

      def find_review_settings
        @review_setting = current_store.review_setting
      end

      def review_setting_params
        params.require(:review_setting).permit(:include_unapproved_reviews, :feedback_rating, :show_email, :require_login, :track_locale, :show_identifier, :preview_size, :paginate_size).merge(store: current_store)
      end
    end
  end
end
