class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @user = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    render :new if @order.invalid?
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to orders_confirm_path
  end

  def index
  end

  def show
  end

  private

  def order_params
   params.require(:order).permit(:customer_id,:postal_code,:address,:name,:shipping,:total_payment,:payment_method,:status,:created_at,:updated_at)
  end

end
