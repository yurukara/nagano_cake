class Public::AddressesController < ApplicationController
  
  def index
    @address = Address.new
    @addresses = current_member.addresses
  end
  
  def create
    @address = Address.new(address_params)
    @address.member_id = current_member.id
    @address.save
    redirect_to request.referer
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先の情報を更新しました"
    else
      redirect_to request.referer
      # 本当はrenderにしたいのですが、空白にした状態で更新掛けようとするとエラーが出てしまうので、時間あったら直します(要件定義にはないはず)
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to request.referer, notice: "配送先の情報を削除しました"
  end


  private
  
  def address_params
    params.require(:address).permit(:address, :postal_code, :shipping_name)
    # 住所、郵便番号、宛名の保存を許可しています。
  end
end