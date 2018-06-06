class DashboardController < ApplicationController
  def index

  end

  def show
    @orders = current_user.orders
  end
end
