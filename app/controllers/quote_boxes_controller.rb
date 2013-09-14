class QuoteBoxesController < ApplicationController
  # GET /quote_boxes
  # GET /quote_boxes.json
  def index
    @quote_boxes = QuoteBox.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quote_boxes }
    end
  end

  # GET /quote_boxes/1
  # GET /quote_boxes/1.json
  def show
    @quote_box = current_quote_box(true)
    #TODO: redo this with quicker select sql.
    @hairstyles = []
    @accessories = []
    @appointments = []

    if @quote_box
      @quote_box.line_items.each do |line_item|
        @hairstyles << [Hairstyle.find(line_item.quotable_id),line_item.id] if line_item.quotable_type == "Hairstyle"
        @accessories << [Accessory.find(line_item.quotable_id),line_item.id] if line_item.quotable_type == "Accessory"
        @appointments << [Appointment.find(line_item.quotable_id),line_item.id] if line_item.quotable_type == "Appointment"
      end
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quote_box }
    end
  end

  # GET /quote_boxes/new
  # GET /quote_boxes/new.json
  def new
    @quote_box = QuoteBox.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quote_box }
    end
  end

  # GET /quote_boxes/1/edit
  def edit
    @quote_box = QuoteBox.find(params[:id])
  end

  # POST /quote_boxes
  # POST /quote_boxes.json
  def create
    @quote_box = QuoteBox.new(params[:quote_box])

    respond_to do |format|
      if @quote_box.save
        format.html { redirect_to @quote_box, notice: 'Quote box was successfully created.' }
        format.json { render json: @quote_box, status: :created, location: @quote_box }
      else
        format.html { render action: "new" }
        format.json { render json: @quote_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quote_boxes/1
  # PUT /quote_boxes/1.json
  def update
    @quote_box = QuoteBox.find(params[:id])

    respond_to do |format|
      if @quote_box.update_attributes(params[:quote_box])
        format.html { redirect_to @quote_box, notice: 'Quote box was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quote_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quote_boxes/1
  # DELETE /quote_boxes/1.json
  def destroy
    @quote_box = current_quote_box
    @quote_box.destroy
    session[:quote_box_id] = nil

    respond_to do |format|
      format.html { redirect_to quote_box_url }
      format.json { head :no_content }
    end
  end
end
