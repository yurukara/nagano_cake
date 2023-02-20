class Public::OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  # ↑　トークン認証する為の記述
  
  def new
    @order = Order.new
    @address = Address.new
    @address.member_id = current_member.id
    @addresses = current_member.addresses.all
  end
  
  def confirm
      @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.post_code = current_member.postal_code
      @order.address = current_member.address
      @order.shipping_name = current_member.last_name + current_member.first_name
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:member_id])
      @order.post_code = ship.postal_code
      @order.address = ship.address
      @order.shipping_name = ship.shipping_name
    elsif params[:order][:address_option] = "2"
      @order.post_code = params[:order][:shipping_post_code]
      @order.address = params[:order][:shipping_address]
      @order.shipping_name = params[:order][:shipping_name]
    else
      render 'new'
    end
    @cart_items = current_member.cart_items.all
  end
  
  def create
    @order = Order.new(order_params)
    @order.member_id = current_member.id
    @order.save
    
    current_member.cart_items.each do |cart_item|
      @order_item = OrderItem.new
      @order_item.item_id = cart_item.item_id
      @order_item.quantity = cart_item.quantity
      @order_item.tax_in_price = cart_item.item.with_tax_price
      @order_item.order_id = @order.id
      @order_item.save
    end
    
    current_member.cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def thanks
  end

  def index
    @orders = current_member.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
  
  private
  
  def order_params
    params.require(:order).permit(:member_id, :postage, :address, :post_code, :shipping_name, :total_payment, :payment_method, :order_status)
  end
end
