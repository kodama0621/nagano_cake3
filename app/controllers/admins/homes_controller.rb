class Admins::HomesController < ApplicationController
  def top
    path = Rails.application.routes.recognize_path(request.referer)
    #byebug
    if path[:controller] == "admin/customers" && path[:action] == "show"
      @orders = Order.where(customer_id: path[:id]).page(params[:page]).reverse_order
    else
      @orders = Order.all.page(params[:page]).reverse_order
    end
  end
end
