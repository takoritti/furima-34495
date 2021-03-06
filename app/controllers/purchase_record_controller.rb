class PurchaseRecordController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:index, :create]

  def index
    @purchase_record = PurchaseRecordShippingInformation.new
    if @item.user.id == current_user.id
      redirect_to root_path
    elsif @item.purchase_record != nil
      redirect_to root_path
    end
  end

  def create
    @purchase_record = PurchaseRecordShippingInformation.new(purchase_record_params)
    if @purchase_record.valid?
      pay_item
      @purchase_record.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_record_shipping_information).permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_record_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
