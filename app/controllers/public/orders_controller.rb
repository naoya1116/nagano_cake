class Public::OrdersController < ApplicationController
   before_action :cart_item_any?, only: [:new, :confirm]

   #管理者とログインユーザーのみ閲覧可
	 #before_action :authenticate!
   #退会済みユーザーは閲覧不可
   #before_action :customer_is_deleted
   #param[:id]が取得できない場合、閲覧不可
   #before_action :params_check, only: [:index]


  def new
    @user = current_customer
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.price*1.1).floor * cart_item.amount
    end

    if session[:order]["payment_method"] == "0"
      @payment_method = "クレジット払い"
    elsif session[:order]["payment_method"] == "1"
      @payment_method = "銀行振り込み"
    end
  end

  def complete

    #注文履歴の保存
    order = Order.new(session[:order])
    cart_items = current_customer.cart_items
    total_price = 0
    cart_items.each do |cart_item|
      total_price += (cart_item.item.price*1.1).floor * cart_item.amount
    end
    order.shipping = 800
    order.total_payment = total_price+order.shipping
    order.status = 0
    order.customer_id = current_customer.id
    order.save

    #注文済み商品の保存
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.item_id = cart_item.item.id
      order_item.makeing_status = 0
      order_item.price = cart_item.item.price*1.1
      order_item.amount = cart_item.amount
      order_item.order_id = order.id
      order_item.save
    end
    cart_items.destroy_all
  end

  def create
    session[:order] = Order.new()

    if params[:payment_select] == "0"
      session[:order][:payment_method] = 0
    elsif params[:payment_select] == "1"
      session[:order][:payment_method] = 1
    end

    if params[:address_select] == "0"
      session[:order][:postal_code] = current_customer.postal_code
      session[:order][:address] = current_customer.address
      session[:order][:name] = current_customer.last_name+current_customer.first_name
    elsif params[:address_select] == "1"
      session[:order][:postal_code] =  Address.find(params[:deliver]).postal_code
      session[:order][:address] = Address.find(params[:deliver]).address
      session[:order][:name] = Address.find(params[:deliver]).name
    else
      session[:order][:postal_code] =  params[:postal_code]
      session[:order][:address] = params[:address]
      session[:order][:name] = params[:name]
    end
    redirect_to orders_confirm_path

  end

  def index
    @orders = current_customer.order.all
  end

  def show
    @order = Order.find(params[:id])
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.price*1.1).floor * cart_item.amount
    end
  end

  private

  def order_params
   params.require(:order).permit(:customer_id,:postal_code,:address,:name,:shipping,:total_payment,:payment_method,:status,:created_at,:updated_at)
  end

  def cart_item_any?
    if current_customer.cart_items.empty?
      redirect_to items_path
    end
  end

end
