class ReviewCreateReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    ReviewMailer.notify_product_owner(Review.last).deliver_now
    # ReviewMailer.notify_product_owner(Review.last).deliver_later(wait: 10.seconds)
    # ReviewMailer.notify_product_owner(Review.last).deliver_later(wait: 2.minutes)
  end
end
