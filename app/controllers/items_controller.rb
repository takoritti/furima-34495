class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :item, only: [:show, :edit, :update, :destroy]
  before_action :judge, only: [:edit, :update, :destroy]

  def index
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

  def show
  end

  def edit
    unless @item.purchase_record == nil
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end
  
  def destroy
    @item.destroy
    redirect_to root_path
  end
end

private

def item_params
  params.require(:item).permit(:name, :information, :category_id, :status_id, :shipping_fee_id, :prefecture_id,
                               :shipping_day_id, :price, :image)
        .merge(user_id: current_user.id)
end

def item
  @item = Item.find(params[:id])
end

def judge
  unless @item.user.id == current_user.id
    redirect_to action: :index
  end
end
