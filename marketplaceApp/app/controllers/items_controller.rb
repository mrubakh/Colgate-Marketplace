class ItemsController < ApplicationController
  def index
    #order = "name"
    #@items = Item.sorted_by(order)
    @items = Item.all
  end
    
  def show
    id = params[:id]
    @item = Item.find(id)
  end
    
end
