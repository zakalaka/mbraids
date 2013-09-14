class HairstyleCollectionsController < ApplicationController
  def index

  end

  def ladies
    @h2_header_prefix = "l"
    @hairstyle_collections = HairstyleCollection.where(["displayable_flag = ? and collection_type = ?",
    true, 'L'])
    respond_to do |format|
      format.html {render :collection_list}
    end
  end
  def girls
    @h2_header_prefix = "g"
    @hairstyle_collections = HairstyleCollection.where(["displayable_flag = ? and collection_type = ?",
    true, 'G'])
    respond_to do |format|
      format.html {render :collection_list}
    end
  end


  def new
    @hairstyle_collection = HairstyleCollection.new
  end

  def create
    @hairstyle_collection = HairstyleCollection.new(params[:hairstyle_collection])

    respond_to do |format|
      if @hairstyle_collection.save
        format.html {redirect_to hairstyle_collections_path, notice: '.create_hairstyle_collection_successful'}
      else
        format.html {render action: 'new', alert: '.create_hairstyle_collection_unsuccessful'}
      end
    end
  end

  def edit
    @hairstyle_collection = HairstyleCollection.find(params[:id])
  end

  def update
    @hairstyle_collection = HairstyleCollection.find(params[:id])

    respond_to do |format|
      if @hairstyle_collection.update_attributes(params[:hairstyle_collection])
        format.html { redirect_to hairstyle_collections_path, notice: '.update_hairstyle_collection_successful' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hairstyle_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hairstyle_collection = HairstyleCollection.find(params[:id])
    #TODO: see if this child deletion can be done better
    @hairstyle_collection.hairstyles.each do |hairstyle|
      begin
        File.delete(Rails.root.join('app','assets','uploads',hairstyle.image))
      rescue

      end
      hairstyle.destroy
    end
    @hairstyle_collection.destroy

    respond_to do |format|
      format.html { redirect_to hairstyle_collections_url }
      format.json { head :no_content }
    end
  end
end
