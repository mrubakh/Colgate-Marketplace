class ItemsController < ApplicationController
  
  # before_action :has_user, :only => [:new, :create]
  
  # protected
  # def has_user
  #   unless @user
  #     flash[:warning] = 'You must be logged in to list an item.'
  #     redirect_to new_user_path
  #   end
  #   unless (@user = User.where(:id => params[:user_id]))
  #     flash[:warning ] = 'An item must be listed for an existed User.'
  #     # redirect_to items_path
  #   end
  # end
  
  def index
    order = params[:order] || "name"
    @items = Item.all.order(order)
  end
    
  def show
    if params[:id]
      @item = Item.find(params[:id])
      @seller = User.find(@item.user_id).name
      @sellerID = @item.user_id
    end
  end
  
  def new 
    @item = current_user.items.build
  end
  
  def create
    
    @item = Item.new(item_params)
    params[:item][:status] = "available"
    current_user.items << current_user.items.build(item_params)
    flash[:notice] = "New item \"#{@item.name}\" listed"
    redirect_to items_path and return
  end
  
  def search
    if !params[:search].empty?
      @phrase = params[:search]
      @items = Item.all.where("lower(name) LIKE :phrase", phrase: @phrase) 
      render "items/index" and return
    else
      flash[:alert] = "Empty Search"
      redirect_to root_path and return
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
