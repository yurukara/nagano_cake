class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!


  def index

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(:genre_id,:name, :introduction, :price, :is_active, :image)
  end
end
