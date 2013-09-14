class AccessoriesController < ApplicationController
  # GET /accessories
  # GET /accessories.json
  def index
    @category = Category.find(params[:category_id])
    @accessories = @category.accessories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accessories }
    end
  end

  # GET /accessories/1
  # GET /accessories/1.json
  #def show
  #  @accessory = Accessory.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @accessory }
  #  end
  #end

  # GET /accessories/new
  # GET /accessories/new.json
  def new
    @category = Category.find(params[:category_id])
    @accessory = @category.accessories.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accessory }
    end
  end

  # GET /accessories/1/edit
  def edit
    @accessory = Accessory.find(params[:id])
  end

  # POST /accessories
  # POST /accessories.json
  def create
    @category = Category.find(params[:category_id])
    @accessory = @category.accessories.new(params[:accessory])

    uploaded_file = params[:accessory][:image]
    @accessory.image = set_image_filename(uploaded_file.original_filename)

    respond_to do |format|
      if @category.accessories << @accessory
        #TODO: important: wb stands for write binary mode to avoid utf-8 conversion error
        File.open(Rails.root.join('app','assets','uploads',@accessory.image),'wb') do |file|
          file.write(uploaded_file.read)
        end
        format.html {redirect_to category_accessories_path, notice: '.create_accessory_successful'}
      else
        format.html {render action: 'new', alert: '.create_accessory_unsuccessful'}
      end
    end
  end

  # PUT /accessories/1
  # PUT /accessories/1.json
  def update
    @accessory = Accessory.find(params[:id])

    respond_to do |format|
      if @accessory.update_attributes(params[:accessory])
        format.html { redirect_to @accessory, notice: 'Accessory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accessory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accessories/1
  # DELETE /accessories/1.json
  def destroy
    @accessory = Accessory.find(params[:id])
    @accessory.destroy

    respond_to do |format|
      format.html { redirect_to accessories_url }
      format.json { head :no_content }
    end
  end
end
