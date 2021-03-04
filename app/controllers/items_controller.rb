class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path(@items)
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
  params.require(:item).permit(:content, :image).merge(user_id: current_user.id)
end