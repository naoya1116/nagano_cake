class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_item = @order.order_items

    #商品合計
    @total = 0
    @order_item.each do |order_item|
      pay = order_item.item.price * order_item.amount
      @total += pay
    end
  end

  def update
    order = Order.find(params[:id])

    #注文ステータスが"入金確認"になったら製作ステータスを"製作待ち"
    if params[:order][:status] == "1"
      order.order_items.each do |order_item|
        order_item.makeing_status = "1"
        order_item.update(makeing_status: order_item.makeing_status)
      end
    end
    order.update(order_params)
    redirect_to admin_order_path(order.id)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
