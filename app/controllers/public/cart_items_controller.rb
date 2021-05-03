class Public::CartItemsController < ApplicationController
  # ログインユーザーのみ閲覧可
  # before_action :authenticate_current_customer!
  # 退会済みユーザーは閲覧不可
  # before_action :customer_is_deleted

  def index
    @cart_items = current_customer.cart_items
     @total = 0
     @cart_items.each do |cart_item|
      tal = cart_item.item.price * cart_item.amount
      @total += tal
    end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    #@cart_item.item_id = params[:item_id].to_i
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
   params.require(:cart_item).permit(:customer_id,:item_id,:amount,:amount)
  end

end
