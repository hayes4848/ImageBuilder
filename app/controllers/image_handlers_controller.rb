class ImageHandlersController < ApplicationController
  before_action :set_image_handler, only: [:show, :edit, :update, :destroy]

  # GET /image_handlers
  # GET /image_handlers.json
  def index
    @image_handler = ImageHandler.new
    @image_handlers = ImageHandler.all
  end

  # GET /image_handlers/1
  # GET /image_handlers/1.json
  def show
  end

  # GET /image_handlers/new
  def new
    @image_handler = ImageHandler.new
  end

  # GET /image_handlers/1/edit
  def edit
  end

  def create
    image = MiniMagick::Image.open('public/drumpf.png')
    image_two = MiniMagick::Image.open(params[:image_handler][:image_two].tempfile.path)
    image.format "png"
    image_two.format "png"
    image.resize "500x500"
    image_two.resize "500x500"

    image_two.combine_options do |mogrify|
        mogrify.alpha 'on'
        mogrify.channel 'a'
        mogrify.evaluate 'set', '35%'
    end

    result = image.composite(image_two) do |comp|
      comp.compose "Over"
      comp.geometry "+0+0" # copy second_image onto first_image from (20, 20)
    end
    # result.rename "drumping.png"
    result.format "png"

    @uploader = ProfilePictureUploader.new

    @uploader.store!(result)
    @uploader.retrieve_from_store!('something.jpg')

    respond_to do |format|
      format.html{ redirect_to image_page_path }
    end
  end

  def image_page
    @uploader = ProfilePictureUploader.new 
    @uploader.retrieve_from_store!('something.jpg')
  end 

  def update
    respond_to do |format|
      if @image_handler.update(image_handler_params)
        format.html { redirect_to @image_handler, notice: 'Image handler was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_handler }
      else
        format.html { render :edit }
        format.json { render json: @image_handler.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image_handler.destroy
    respond_to do |format|
      format.html { redirect_to image_handlers_url, notice: 'Image handler was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_handler
      @image_handler = ImageHandler.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_handler_params
      params.fetch(:image_handler, {})
    end
end
