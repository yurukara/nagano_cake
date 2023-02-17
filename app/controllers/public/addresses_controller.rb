class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end
  
  def create
    @address = Address.new(address_params)
    @address.member_id = current_member.id
    @address.save
    redirect_to request.referer
  end

  def edit
  end


  private
  
  def address_params
    params.require(:address).permit(:address, :postal_code, :shipping_name)
    # 住所、郵便番号、宛名の保存を許可しています。
  end
end