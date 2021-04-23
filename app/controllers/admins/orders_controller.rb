class Admins::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @sum = 0
    @order.order_items.each do |order_item|
      @sum += order_item.sub_total
    end
  end

  def update
  end
end
