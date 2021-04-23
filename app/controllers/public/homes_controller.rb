class Public::HomesController < ApplicationController
  def top
    @items = Item.order(:created_at)
  end
end
