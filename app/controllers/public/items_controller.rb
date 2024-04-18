class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @items = Item.all.page(params[:page]).per(8).order(created_at: :DESC)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    
    if params[:cart_item] && params[:cart_item][:amount].present?
      @cart_item.amount = params[:cart_item][:amount].to_i
      if @cart_item.save
        redirect_to cart_path, notice: "カートに追加しました"
      else
        flash.now[:alert] = "個数を選択してください"
        render action: "show"
      end
    end
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
