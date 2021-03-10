class PurchaseRecordController < ApplicationController

  def index
    @purchase_record = PurchaseRecord.includes(:user)
  end

  def create
    @shipping_information_purchase_record = ShippingInformationPurchaseRecord.new(purchase_record_params)
  end

  private
  def purchase_record_params
    params.require(:shipping_information_purchase_record).permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
