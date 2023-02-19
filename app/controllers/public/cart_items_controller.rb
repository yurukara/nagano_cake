class Public::CartItemsController < ApplicationController


  def index
    @cart_items = current_member.cart_items
    @total = @cart_items.inject(0) {|sum, item| sum + item.subtotal}
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

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to request.referer
  end

  def destroy_all
    current_member.cart_items.destroy_all
    redirect_to request.referer
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity,:member_id,:item_id)
  end
  
end
