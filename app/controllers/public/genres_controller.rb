class Public::GenresController < ApplicationController

  def show

    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items = @genre.items.order(created_at: :desc).page(params[:page]).per(8)
  end

end
