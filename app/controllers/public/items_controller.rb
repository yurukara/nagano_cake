class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
    else
      @items = Item.all
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end

  private

  def item_params
    params.require(:items).permit(:genre_id, :name, :introduction, :image, :price)
  end
  
end
