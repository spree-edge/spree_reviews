class Spree::Review < ActiveRecord::Base
  belongs_to :product, touch: true
  belongs_to :user, class_name: Spree.user_class.to_s
  belongs_to :store, class_name: 'Spree::Store', foreign_key: 'store_id'
  has_many   :feedback_reviews
  belongs_to :review_setting

  after_save :recalculate_product_rating, if: :approved?
  after_destroy :recalculate_product_rating

  validates :name, :review, presence: true
  validates :rating, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    message: :you_must_enter_value_for_rating
  }

  default_scope { order('spree_reviews.created_at DESC') }

  scope :localized, ->(lc) { where('spree_reviews.locale = ?', lc) }
  scope :most_recent_first, -> { order('spree_reviews.created_at DESC') }
  scope :oldest_first, -> { reorder('spree_reviews.created_at ASC') }
  scope :preview, ->(review_setting) { limit(review_setting&.preview_size).oldest_first }
  scope :approved, -> { where(approved: true) }
  scope :not_approved, -> { where(approved: false) }
  scope :default_approval_filter, ->(review_setting) { review_setting&.include_unapproved_reviews ? all : approved }

  whitelisted_ransackable_associations = ['store']

  def feedback_stars
    return 0 if feedback_reviews.size <= 0

    ((feedback_reviews.sum(:rating) / feedback_reviews.size) + 0.5).floor
  end

  def recalculate_product_rating
    product.recalculate_rating if product.present?
  end

  def self.ransackable_associations(auth_object = nil)
    ["feedback_reviews", "product", "review_setting", "store", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["approved", "name", "review", "title"]
  end
end
