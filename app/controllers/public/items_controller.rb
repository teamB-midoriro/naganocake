class Public::ItemsController < ApplicationController

  def index
    @items = Item.all.page(params[:page]).per(8).order(created_at: :DESC)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  # def genre_search
  #   @genre = Grenre.find(params[:id])
  #   @items = @genre.items.order(created_at: :DESC)
  # end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :item_image, :genre_id)
  end
end
