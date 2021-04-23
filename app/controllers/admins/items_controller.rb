class Admins::ItemsController < ApplicationController
   def index
    @items = Item.all.page(params[:page])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    item = Item.new(item_params)
    if item.save
      flash[:success] = "商品の登録に成功しました！"
      redirect_to admins_item_path(item)
    else
      flash[:danger] = "商品の登録に失敗しました。内容を確認してください"
      @item = Item.new
      @genres = Genre.all
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:success] = "内容が更新されました！"
      redirect_to admins_item_path(item.id)
    else
      flash[:danger] = "更新に失敗しました。内容を確認してください"
      @item = Item.find(params[:id])
      @genres = Genre.all
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_active,:genre_id)
  end
end
