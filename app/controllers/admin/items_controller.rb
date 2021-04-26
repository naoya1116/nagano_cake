class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
   @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    # @item.genre_id = params[:item][:genre_id].to_i
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  private

  def item_params
   params.require(:item).permit(:name,:image,:introduction,:price,:is_active,:created_at,:updated_at, :genre_id)
  end

end