class ItemsController < ApplicationController
  def index
    order = params[:order] || "name"
    @items = Item.all.order(order)
  end
    
  def show
    if params[:id]
      @item = Item.find(params[:id])
      @seller = User.find(@item.user_id).name
    end
  end
end
