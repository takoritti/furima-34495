class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path

    else
      render :new
    end
  end

  # def destroy
  #   item = Item.find(params[:id])
  #   item.destroy
  #   redirect_to root_path
  # end
end

private

def item_params
  params.require(:item).permit(:name, :information, :category_id, :status_id, :shipping_fee_id, :prefecture_id,
                               :shipping_day_id, :price, :image)
        .merge(user_id: current_user.id)
end
