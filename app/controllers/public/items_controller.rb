class Public::ItemsController < ApplicationController
  def index
    @item = Item.where(is_active: 'true').count
    @items = Item.order(:created_at)
    @items = Item.page(params[:page]).reverse_order.per(8)
  end

  def show
    @item = Item.find(params[:id])
  end
end
