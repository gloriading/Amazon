class ReviewMailer < ApplicationMailer
  def notify_product_owner(review)
    @review = review
    @review_owner = review.user
    @product = review.product
    @product_owner = review.product.user
    mail(
      to: 'gloria.hc.ding@gmail.com',
      subject: 'There is a new review to your product.'
    )
  end
end
