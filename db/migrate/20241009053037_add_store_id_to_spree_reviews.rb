class AddStoreIdToSpreeReviews < ActiveRecord::Migration[7.1]
  def change
    add_reference :spree_reviews, :store, foreign_key: { to_table: :spree_stores }
  end
end
