class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all.page(params[:page]).per(10).order(created_at: :ASC)

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id), notice: "商品を登録しました"
    else
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
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品を更新しました"
    else
      render :edit
    end

  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :item_image, :genre_id)
  end

end
