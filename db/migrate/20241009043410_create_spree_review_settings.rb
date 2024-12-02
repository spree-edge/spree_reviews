class CreateSpreeReviewSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :spree_review_settings do |t|
      t.boolean :include_unapproved_reviews, default: false
      t.integer :preview_size, default: 3
      t.boolean :show_email, default: false
      t.boolean :feedback_rating, default: false
      t.boolean :require_login, default: false
      t.boolean :track_locale, default: false
      t.boolean :show_identifier, default: false
      t.integer :paginate_size, default: 10
      t.integer :store_id
      t.timestamps
    end
  end
end
