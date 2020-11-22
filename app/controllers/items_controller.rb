class ItemsController < ApplicationController
  
  before_action :has_user, :only => [:new, :create]
  
  def has_user
    unless current_user
      flash[:warning] = 'You must be logged in to perform this action.'
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
      @seller = User.find(@item.user_id)
      @sellerID = @item.user_id
    end
  end
  
  def new 
    @item = current_user.items.build
  end
  
  def create
    params[:item][:status] = "available"
    params[:item][:listed] = true
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
      @phrase = @phrase.downcase
      @items = Item.search(@phrase)
      render "items/index" and return
    else
      flash[:alert] = "Empty Search"
      redirect_to root_path and return
    end
  end
  
  def send_interest_email
    # will refactor in next iteration
    @item = Item.find(params[:id])
    if current_user
      @seller = User.find(@item.user_id)
      @buyer = current_user
      EmailMailer.with(@seller).interest_email(@seller, @buyer, @item).deliver_now
      flash[:notice] = "Email has been sent."
      redirect_to item_path(@item.id)
    else
      flash[:warning] = "Need to be logged in to contact seller"
      redirect_to item_path(@item.id)
    end
  end

  private
    def record_not_found
      redirect_to action: "index"
    end
    
    def item_params
      params.require(:item).permit(:name, :description, :price, :image, :deliverable, :status, :listed, :category)
    end
end
