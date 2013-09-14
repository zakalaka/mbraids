class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @order_image = @order.order_image || @order.build_order_image

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(user_id: current_user)
    @order.quote_box = QuoteBox.find(session[:quote_box_id])

    respond_to do |format|
      if @order.save
        session[:quote_box_id] = nil
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        begin
          QuoteBox.find(session[:quote_box_id]).line_items.first(conditions: "quotable_type = 'Appointment'").destroy
        rescue
        end
        format.html { render action: "new" }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_image
    @order = Order.find(params[:user_image][:order_id])
    uploaded_file = params[:user_image][:image]

    respond_to do |format|
      if @order.create_order_image(image: set_image_filename(uploaded_file.original_filename))
        File.open(Rails.root.join('app','assets','uploads',@order.order_image.image),'wb') do |file|
          file.write(uploaded_file.read)
        end
        format.html { redirect_to root_path, notice: 'ok!' }
      else
        format.html { render action: 'show', notice: 'not ok' }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
