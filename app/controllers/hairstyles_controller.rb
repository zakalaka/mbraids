class HairstylesController < ApplicationController
  def index
    #@hairstyles = Hairstyle.all
    @hairstyle_collection = HairstyleCollection.find(params[:hairstyle_collection_id])
    @hairstyles = @hairstyle_collection.hairstyles
  end

  def show
    @hairstyle_collection = HairstyleCollection.find(params[:hairstyle_collection_id])
    @hairstyle = Hairstyle.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hairstyle }
    end
  end


  def new
    #@hairstyle = Hairstyle.new
    @hairstyle_collection = HairstyleCollection.find(params[:hairstyle_collection_id])
    @hairstyle = @hairstyle_collection.hairstyles.new
  end

  def create
    @hairstyle_collection = HairstyleCollection.find(params[:hairstyle_collection_id])
    @hairstyle = @hairstyle_collection.hairstyles.new(params[:hairstyle])

    uploaded_file = params[:hairstyle][:image]
    @hairstyle.image = set_image_filename(uploaded_file.original_filename)

    respond_to do |format|
      if @hairstyle_collection.hairstyles << @hairstyle
        #TODO: important: wb stands for write binary mode to avoid utf-8 conversion error
        File.open(Rails.root.join('app','assets','uploads',@hairstyle.image),'wb') do |file|
          file.write(uploaded_file.read)
        end
        format.html {redirect_to hairstyle_collection_hairstyles_path, notice: '.create_hairstyle_successful'}
      else
        format.html {render action: 'new', alert: '.create_hairstyle_unsuccessful'}
      end
    end
  end

  def edit
    @hairstyle_collection = HairstyleCollection.find(params[:hairstyle_collection_id])
    @hairstyle = @hairstyle_collection.hairstyles.find(params[:id])
  end

  def update
    #@hairstyle_collection = HairstyleCollection.find(params[:hairstyle_collection_id])
    @hairstyle = Hairstyle.find(params[:id])
    old_filename = @hairstyle.image
    uploaded_file = params[:hairstyle][:image]
    new_filename = set_image_filename(uploaded_file.original_filename)
    respond_to do |format|
      if @hairstyle.update_attributes(params[:hairstyle])
        begin
          File.delete(Rails.root.join('app','assets','uploads',old_filename))
        rescue
        end
        File.open(Rails.root.join('app','assets','uploads',new_filename),'wb') do |file|
          file.write(uploaded_file.read)
        end
        format.html { redirect_to hairstyles_path, notice: '.update_hairstyle_successful' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hairstyle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hairstyle = Hairstyle.find(params[:id])
    @hairstyle.destroy
    begin
      File.delete(Rails.root.join('app','assets','uploads',@hairstyle.image))
    rescue

    end
    respond_to do |format|
      format.html { redirect_to hairstyle_collection_hairstyles_url }
      format.json { head :no_content }
    end
  end
end
