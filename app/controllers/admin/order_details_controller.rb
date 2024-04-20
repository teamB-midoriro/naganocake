class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_detail.all
    
    is_updated = true
    if @order_detail.update(making_status_params)
      # 制作ステータスが制作中の時は注文ステータスを制作中にする
      @order.update(status: "making") if @order_detail.making_status == "manufacturing"
        @order_details.each do |order_detail|
          if order_detail.making_status != "finish"
            is_updated = false
          end
        end 
      @order.update(status: "preparing_ship") if is_updated
    end
    redirect_to admin_order_path(@order)
  end
  
  private
  def making_status_params
    params.require(:order_detail).permit(:making_status)
  end
end
