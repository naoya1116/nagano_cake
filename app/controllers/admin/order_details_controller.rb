class Admin::OrderDetailsController < ApplicationController

    def update
        order_item = OrderItem.find(params[:order_item][:order_item_id])
        order = order_item.order

        #注文商品の製作ステータスが1つでも“製作中“であれば注文ステータスを“製作中“に更新
        if params[:order_item][:makeing_status] == "製作中"
          order.update(status: "製作中")
        end
        order_item.update(makeing_status: params[:order_item][:makeing_status])

        #注文商品全ての製作ステータスが“製作完了“で注文ステータスを“発送準備中“に
        order = Order.find(params[:id])
        if  order.order_items.all? do |p|
              p.makeing_status == "製作完了"
            end
            order.update(status: "発送準備中")
            flash[:success] = "注文ステータスが「発送準備中」に更新されました"
        end
        redirect_to admin_order_path
    end

end
