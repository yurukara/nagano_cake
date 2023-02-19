class Public::CartItemsController < ApplicationController


  def index
    @cart_items = current_member.cart_items
    @total = @cart_items.inject(0) {|sum, item| sum + item.subtotal}
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
