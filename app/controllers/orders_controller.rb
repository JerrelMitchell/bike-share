class OrdersController < ApplicationController

  def create
    @order = Order.create(user_id: current_user.id)
    @order.assign_accessories(@cart.contents)
    flash[:notice] = "Successfully submitted your order totaling: $#{@order.total_price}"
    redirect_to '/dashboard'
  end

  def show
    @order = Order.find(params[:id])
  end
end