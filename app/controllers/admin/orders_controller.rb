class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
   @order = Order.find(params[:id])
   @order_item = @order.order_items
  end

  def update
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: params[:id])
    if @order.update(order_params)
      @order_items.update_all(production_status: 1 ) if @order.order_status == "payment_confirmation"
    end
    redirect_to request.referer
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
