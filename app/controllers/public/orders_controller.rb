class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @user = current_customer

   
  end

  def confirm
    @order = Order.new
    @order.payment_method = params[:order][:payment_method]

    if params[:order][:address] == "1"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name+current_customer.first_name

    elsif params[:order][:address] == "2"
    delivery = Address.find(params[:order][:delivery])
    @order.postal_code = delivery.postal_code
    @order.address = delivery.address
    @order.name = delivery.name

    elsif params[:order][:address] == "3"
    @order.name = params[:order][:name]
    @order.postal_code = params[:order][:postal_code]
    @order.address = params[:order][:address]
    end
    
   if @order.invalid?
      @user = current_customer
      render :new
   end

  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to orders_complete_path
    else
      flash.now[:danger] = "登録に失敗しました。"
      render :new
    end

    if params[:back].present?
      render :new
      return
    end
  end

  def index
    @orders = current_customer.ordered_items
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
   params.require(:order).permit(:customer_id,:postal_code,:address,:name,:shipping,:total_payment,:payment_method,:status,:created_at,:updated_at)
  end

end
