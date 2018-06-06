class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
    @all_orders = Order.all
    @grouped_by_status = @orders.by_status
    @paid_orders = Order.orders_paid
    @cancelled_orders = Order.orders_cancelled

    if params[:type] == 'cancelled'
    @orders = Order.orders_cancelled
  elsif params[:type] == 'completed'
    @orders = Order.orders_completed
  elsif params[:type] == 'ordered'
    @orders = Order.orders_ordered
  elsif params[:type] == 'paid'
    @orders = Order.orders_paid
  end
  end

  def show
    @order = Order.find(params[:id])
  end

  def status
    redirect_to :index
  end
  
  def update
    params["order"]["status"] = (params["order"]["status"])
    order = Order.find(params[:id])
    if order.update(order_params)
      flash[:success] = "You have updated the order to #{params["order"]["status"]}!"
    end
    redirect_to admin_dashboard_path
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end

