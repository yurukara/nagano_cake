class Admin::OrderDetailsController < ApplicationController
   before_action :authenticate_admin!

   def update
     @order = Order.find(params[:order_id])
     @order_item = OrderItem.find(params[:id])
     @order_items = @order.order_items.all

     is_updated = true

    if @order_item.update(order_item_params)
      @order.update(order_status: 2 ) if @order_item.production_status == "in_production"
      @order_items.each do |order_item|
        if order_item.production_status != "production_complete"
          is_updated = false
        end
      end
      @order.update(order_status: 3) if is_updated
    end
      redirect_to request.referer
   end

   private

   def order_item_params
     params.require(:order_item).permit(:production_status)
   end
end
