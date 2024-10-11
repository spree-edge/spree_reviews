module Spree::ProgressBarHelper
  def rating_count(product, rating)
    product.reviews.approved.where(rating:).count
  end

  def rating_percentage(product, rating)
    total_reviews = product.reviews.approved.count
    return 0 if total_reviews.zero?

    (rating_count(product, rating) * 100.0 / total_reviews).round(2)
  end

  def average_rating(product)
    total_reviews = product.reviews.approved.count
    return 0 if total_reviews.zero?

    total_rating_sum = (1..5).sum { |rating| rating_count(product, rating) * rating }
    (total_rating_sum.to_f / total_reviews).round(1)
  end
end
