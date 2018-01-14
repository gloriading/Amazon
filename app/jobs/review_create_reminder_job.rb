class ReviewCreateReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    ReviewMailer.notify_product_owner(Review.last).deliver_now
  end
end
