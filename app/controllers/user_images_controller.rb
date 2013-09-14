class UserImagesController < ApplicationController
  def create
    @order = Order.find(params[:user_image][:order_id])
    @order.order_image.build(params[:user_image])
    respond_to do |format|
      if @order.save
        format.html {}
      else
      end

    end

    @user_image = UserImage.new(params[:user_image])
  end

  def destroy
  end
end
