class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def update
    data=params.require(:exchange_rate)
    ExchangeRate.find(data[:id]).update_attributes(data.permit(:price, :relevant_until))
    redirect_to action: :index
  end
end
