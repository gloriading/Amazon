class ProductMailer < ApplicationMailer

  def notify_product_owner(product)
    @product = product
    mail(
      to: 'gloria.hc.ding@gmail.com',
      subject: 'You created a new product! Thank you!'
    )
  end
end
