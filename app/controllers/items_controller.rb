class ItemsController < ApplicationController
  
  before_action :has_user, :only => [:new, :create]
  
  def has_user
    unless current_user
      flash[:warning] = 'You must be logged in to list an item.'
      redirect_to new_user_path
    end
  end
  
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
    params[:item][:status] = "available"
    i = current_user.items.build(item_params)
    current_user.items << i
    if i.valid?
      i.image.attach(params[:item][:image])
      flash[:notice] = "New item \"#{i.name}\" listed"
      redirect_to items_path and return
    else
      errmsg = i.errors.full_messages.join(', ')
      flash[:error] = "Error creating new product: #{errmsg}"
      redirect_to new_item_path and return
    end
    
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
  
  def send_interest_email
    logger.debug("HERE")
    logger.debug(params)
    @item = Item.find(params[:id])
    @seller = User.find(@item.user_id)
    @buyer = current_user
    logger.debug(@seller.email)
    if EmailMailer.interest_email(@seller, @buyer, @item).deliver
      flash[:notice] = "Email has been sent."
    end
    redirect_to item_path(@item.id)
  end

  private
    def record_not_found
      redirect_to action: "index"
    end
    
    def item_params
      params.require(:item).permit(:name, :description, :price, :image, :deliverable, :status)
    end
end
