class HairstylesController < ApplicationController
  def index
    #@hairstyles = Hairstyle.all
    @hairstyle_collection = HairstyleCollection.find(params[:hairstyle_collection_id])
    @hairstyles = @hairstyle_collection.hairstyles.paginate(page: params[:page], per_page: 2)
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
    #@hairstyle = Hairstyle.new(params[:hairstyle])
    #logger.debug(@hairstyle.inspect)

    #uploaded_file = params[:hairstyle][:image]
    #@hairstyle.image = "testing"#set_image_filename(uploaded_file.original_filename)
    respond_to do |format|
      if @hairstyle_collection.hairstyles << @hairstyle
      #if @hairstyle.save
        ##TODO: important: wb stands for write binary mode to avoid utf-8 conversion error
        #File.open(Rails.root.join('app','assets','uploads',@hairstyle.image),'wb') do |file|
        #  file.write(uploaded_file.read)
        #end
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
    @hairstyle_collection = HairstyleCollection.find(params[:hairstyle_collection_id])
    @hairstyle = Hairstyle.find(params[:id])
    #if @hairstyle.nil?
    #  raise "unable to find the hairstyle"
    #end
    #old_filename = @hairstyle.image
    #uploaded_file = params[:hairstyle][:image]
    #@hairstyle.image = set_image_filename(uploaded_file.original_filename) if uploaded_file
    respond_to do |format|
      if @hairstyle.update_attributes(params[:hairstyle])
        format.html { redirect_to hairstyle_collection_hairstyles_path, notice: '.update_hairstyle_successful' }
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
    respond_to do |format|
      format.html { redirect_to hairstyle_collection_hairstyles_url, notice: @hairstyle.errors.messages[:base] }
      format.json { head :no_content }
    end
  end

  #private

  #def save_image(image_data, new_image_name = nil, existing_img_name = nil)
  #  if existing_img_name
  #    #replace if new image is present
  #    if image_data && image_data.content_type =~ /^image/
  #      #begin
  #        File.delete(Rails.root.join('app','assets','uploads',existing_img_name))
  #        File.open(Rails.root.join('app','assets','uploads',new_image_name),'wb') do |file|
  #          file.write(image_data.read)
  #        end
  #        params = []
  #        params << Rails.root.join('app','assets','uploads',new_image_name)
  #        params << "-resize 120x120 #{Rails.root.join('app','assets','uploads','new_resized.jpg')}"
  #        #TODO: this relies on existence of simple_captcha plugin
  #        SimpleCaptcha::Utils::run("convert", params.join(' '))
  #        return true
  #      #rescue
  #      #end
  #    end
  #  else
  #    #add, new image must be present
  #    if image_data && image_data.content_type =~ /^image/
  #      begin
  #        File.open(Rails.root.join('app','assets','uploads',new_image_name),'wb') do |file|
  #          file.write(image_data.read)
  #        end
  #        return true
  #      rescue
  #      end
  #    end
  #  end
  #  return false
  #end
end
