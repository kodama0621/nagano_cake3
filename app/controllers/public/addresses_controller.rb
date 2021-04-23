class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:success] = "配送先を登録しました!"
      redirect_to addresses_path
    else
      flash[:danger] = "配送先の登録に失敗しました"
      @address = Address.new
      @addresses = Address.where(customer_id: current_customer.id)
      render "index"
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy!
    redirect_to addresses_path
  end

private
  def address_params
    params.require(:address).permit(:name, :postal_code, :addresses, :customer_id)
  end
end
