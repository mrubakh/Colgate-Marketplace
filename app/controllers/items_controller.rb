class ItemsController < ApplicationController
  
  before_action :has_user, :only => [:new, :create, :update, :unlist]
  
  def has_user
    unless current_user
      flash[:warning] = 'You must be logged in to perform this action.'
      redirect_to items_path
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
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def favorite
    respond_to do |format|
      @item = Item.find(params[:id])
      if params[:commit] == "Unfavorite"
        current_user.favorites.destroy(@item)
        format.html { redirect_to @item, notice: 'Successfully Unfavorited.' }
        format.js
      else 
        current_user.favorites << @item
        format.html { redirect_to @item, notice: 'Successfully Favorited.' }
        format.js

      end
    end
  end
  
  def update
    @item = Item.find(params[:id])
    if (current_user.items.include?(@item) && @item.update_attributes(item_params))
      redirect_to item_path (@item), :notice => "#{@item.name} updated."
    else
      flash[:alert] = "#{@item.name} could not be updated: " + @item.errors.full_messages.join(",")
      render 'edit'
    end
  end
  
  def unlist
    @item = Item.find(params[:id])
    if (current_user.items.include?(@item) && @item.update_attribute(:listed, false))
      redirect_to items_path, :notice => "#{@item.name} unlisted."
    else
      flash[:alert] = "#{@item.name} could not be unlisted: " + @item.errors.full_messages.join(",")
      render 'edit'
    end
  end
  
  def relist
    @item = Item.find(params[:id])
    if (current_user.items.include?(@item) && @item.update_attribute(:listed, true))
      redirect_to items_path, :notice => "#{@item.name} relisted."
    else
      flash[:alert] = "#{@item.name} could not be relisted: " + @item.errors.full_messages.join(",")
      render 'edit'
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
      flash[:notice] = "New item \"#{i.name}\" listed"
      redirect_to items_path and return
    else
      errmsg = i.errors.full_messages.join(', ')
      flash[:error] = "Error creating new product: #{errmsg}"
      redirect_to new_item_path and return
    end
    
  end
  
  def search
    if params[:search].nil?
      q = params[:q].downcase
      @item = Item.search(q)
      render json: @item.select(:name)
    else
      @phrase = params[:search]
      @phrase = @phrase.downcase
      @items = Item.search(@phrase)
      render "items/index" and return
    end
  end
  
  def send_interest_email
    @item = Item.find(params[:id])
    if current_user
      @seller = User.find(@item.user_id)
      @buyer = current_user
      EmailMailer.with(@seller).interest_email(@seller, @buyer, @item).deliver_now
      flash[:notice] = "Email has been sent."
      redirect_to item_path(@item.id)
    else
      flash[:alert] = "Need to be logged in to contact seller"
      redirect_to item_path(@item.id)
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :price, :image, :deliverable, :status, :listed, :category)
    end
end
