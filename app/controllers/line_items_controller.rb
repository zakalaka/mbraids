class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
    LineItem
  end

  # POST /line_items
  # POST /line_items.json
  def create

    @quote_box = current_quote_box

    quotable = find_quotable

    @line_item = @quote_box.add_item(quotable)


    #@line_item = @quote_box.line_items.build(quotable: quotable, :quantity => 2)



    #@line_item = LineItem.new(params[:line_item])

    respond_to do |format|
      if @line_item.errors.size == 0 and @line_item.save
        format.html { redirect_to :back, notice: 'Line item was successfully created.' }
        format.json { render json: :back, status: :created, location: @line_item }
      else
        format.html { redirect_to appointments_url, alert: @line_item.errors[:base].join }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to quote_box_url }
      format.json { head :no_content }
    end
  end

  def find_quotable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  private :find_quotable
end
