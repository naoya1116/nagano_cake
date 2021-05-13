class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!

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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "更新に成功しました"
      redirect_to admin_item_path
    end
  end

  private

  def item_params
   params.require(:item).permit(:name,:image,:introduction,:price,:is_active,:created_at,:updated_at, :genre_id)
  end

end