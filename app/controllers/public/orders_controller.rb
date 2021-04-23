class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @addresses = Address.where(customer_id: current_customer.id)
    @customer = current_customer
    @order = Order.new
  end

  def confirm
    # byebug
    session[:cartitem] = CartItem.where(customer_id: current_customer.id)
    @sum = 0
    session[:cartitem].each do |cart_item|
      @sum += cart_item.sub_total
    end

    session[:order] = current_customer.orders.new(order_params)
    session[:order][:shipping_cost] = 800.to_i
    session[:order][:total_payment] = session[:order][:shipping_cost].to_i + @sum.to_i
		session[:order][:payment_method] = params[:order][:payment_method].to_i
		session[:address_btn]  = params[:order][:address_btn].to_i

		if params[:order][:address_btn].to_i == 0
		  session[:order][:postal_code] = "〒" + current_customer.postal_code
      session[:order][:address] = current_customer.address
      session[:order][:name] = current_customer.fullname

		elsif params[:order][:address_btn].to_i == 1
		  address = Address.find(params[:order][:address_info])
		  session[:order][:postal_code] = address.postal_code
		  session[:order][:address] = address.addresses
		  session[:order][:name] = address.name

		else
		  session[:order][:postal_code] = params[:order][:postal_code]
      session[:order][:address] = params[:order][:address]
      session[:order][:name] = params[:order][:name]
		end
  end

  def create
    order = Order.new(session[:order])
    if order.save
      cart_items = CartItem.where(customer_id: current_customer.id)
      cart_items.each do |i|
        @order_items = order.order_items.new
        @order_items.item_id = i.item.id
        @order_items.price = i.item.taxprice
        @order_items.amount = i.amount
        @order_items.save
      end
      if session[:address_btn].to_i == 2
        address = Address.new
        address.customer_id = current_customer.id
        address.postal_code = session[:order]["postal_code"]
        address.addresses = session[:order]["address"]
        address.name = session[:order]["name"]
        # binding.pry
        address.save
      end
      cart_items.destroy_all
      redirect_to orders_complete_path
    else
      flash[:danger] = "注文に失敗しました。配送先を確認してください"
      redirect_to new_order_path
    end
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
    @sum = 0
    @order.order_items.each do |order_item|
      @sum += order_item.sub_total
    end
  end

  private
  def order_params
    params.permit(:postal_code, :address, :name, :payment_method)
  end

end
