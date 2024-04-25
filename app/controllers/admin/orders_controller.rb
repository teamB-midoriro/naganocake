class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    if params[:order][:status] == 'confirm_payment'
      @order_details.each do |order_detail|
        order_detail.update!(making_status: 'waiting_manufacture')
      end
    end
    redirect_to request.referer, notice: "注文ステータスを更新しました"
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
