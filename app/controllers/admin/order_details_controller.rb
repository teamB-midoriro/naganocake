class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = Order_detail.where(order_id: [@order.id])
    @order_detail.update(order_detail_params)
    if params[:order_detail][:making_status] == 'manufacturing'
      @order.update!(status: 'making')
    elsif params[:order_detail][:making_status] == 'finish'
      if @order_details.all?{|order_detail| order_detail.making_status == 'finish'}
        @order.update!(status: 'preparing_ship')
      end
    end
    redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
