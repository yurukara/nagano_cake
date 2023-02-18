class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_member.cart_items
  end
  
  def create
    @cart_item = current_member.cart_items.new(cart_item_params)
    if current_member.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_member.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.quantity += params[:cart_item][:quantity].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
          @cart_items = current_member.cart_items
          render 'index'
    else
          render 'index'
    end
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :member_id, :quantity)
  end
  
end
