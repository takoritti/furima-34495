class PurchaseRecordController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @purchase_record = PurchaseRecordShippingInformation.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_record = PurchaseRecordShippingInformation.new(purchase_record_params)
    if @purchase_record.valid?
      @purchase_record.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchase_record_params
    params.require(:purchase_record_shipping_information).permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
