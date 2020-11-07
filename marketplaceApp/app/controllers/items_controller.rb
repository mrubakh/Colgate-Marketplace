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
  
  def new 
    @item = Item.new 
  end
  
  def create
    @item = Item.new(item_params)
    @item.status = "available"
    if @item.save!
      flash[:notice] = "New item \"#{@item.name}\" listed"
      redirect_to items_path and return
    else
      flash[:alert] = "Failed to list new item"
      redirect_to new_item_path and return
    end
  end

private
    def record_not_found
      redirect_to action: "index"
    end
    
    def item_params
      params.require(:item).permit(:name, :description, :price, :image, :deliverable, :status)
    end
end
