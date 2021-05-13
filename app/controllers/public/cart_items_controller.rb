class Public::CartItemsController < ApplicationController
  #ログインユーザーのみ閲覧可
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items

    @total = 0
    @cart_items.each do |cart_item|
      pay = cart_item.item.price.to_i * cart_item.amount.to_i
      @total += pay
    end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    #@cart_item.item_id = params[:item_id].to_i
    @cart_item.amount = params[:cart_item][:amount]
    @cart_item.save

    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
   params.require(:cart_item).permit(:customer_id,:item_id,:amount)
  end

end
