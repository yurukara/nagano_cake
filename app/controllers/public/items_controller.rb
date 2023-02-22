class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page]).per(6)
      @count = @genre.items.count 
    else
      @items = Item.page(params[:genre_id]).per(6) 
      @count = Item.all.count
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:items).permit(:genre_id, :name, :introduction, :image, :price)
  end
  
end
