class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path
  end

  private

  def item_params
   params.require(:item).permit(:genre,:name,:image,:introduction,:price,:is_active,:created_at,:updated_at)
  end
  
end