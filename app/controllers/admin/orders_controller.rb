class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    # if @order.update(order_params)
    #   @order_details.update_all(making_atatus: "waiting_manufacture") if @order.status == 'confirm_payment'
    # end
    @order.update(order_params)
    if params[:order][:status] == 'confirm_payment'
      @order_deteils.each do |order_detail|
        order_detail.update!(making_status: 'waiting_manufacture')
      end
    end
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
