class ProductCreateReminderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    ProductMailer.notify_product_owner(Product.last).deliver_now
  end
end
