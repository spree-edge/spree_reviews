class AddReviewSettingIdToSpreeReviews < ActiveRecord::Migration[7.1]
  def change
    add_reference :spree_reviews, :review_setting, foreign_key: { to_table: :spree_review_settings }
  end
end
