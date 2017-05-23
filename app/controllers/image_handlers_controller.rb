class ImageHandlersController < ApplicationController
  before_action :set_image_handler, only: [:show, :edit, :update, :destroy]
  # respond_to :js

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

  def resize_and_crop(image, w, h)
      w_original =image[:width]
      h_original =image[:height]

      if (w_original*h != h_original * w)
        if w_original*h >= h_original * w
          # long width
          h_original_new = h_original
          w_original_new = h_original_new * (w.to_f / h)
        elsif w_original*h <= h_original * w
          # long height
          w_original_new = w_original
          h_original_new = w_original_new * (h.to_f / w)
        end
      else
         # good proportions
         h_original_new = h_original
         w_original_new = w_original

      end

      if w_original_new != w_original || h_original_new != h_original
        x = ((w_original - w_original_new)/2).round
        y = ((h_original - h_original_new)/2).round
        image.crop ("#{w_original_new}x#{h_original_new}+#{x}+#{y}")
      end

      #
      image.resize("#{w}x#{h}")
      return image
  end


  def process_that_ish
    image = MiniMagick::Image.open("public/#{params[:filter]}.png")
    image_two = MiniMagick::Image.open(params[:image_handler][:image_two].tempfile.path)
    image.format "png"
    image_two.format "png"
    image.resize "300x300"
    image_two = resize_and_crop(image_two, 300, 300)

    # image_two.combine_options do |mogrify|
    #     mogrify.alpha 'on'
    #     mogrify.channel 'a'
    #     mogrify.evaluate 'set', '35%'
    # end


    result = image_two.composite(image) do |comp|
      comp.compose "Over"
      comp.geometry "+0+0" # copy second_image onto first_image from (20, 20)
    end
    result.format "png"

    @uploader = ProfilePictureUploader.new

    @uploader.store!(result)

    @uploaded = ProfilePictureUploader.new 
    @uploaded.retrieve_from_store!('something.jpg')

    respond_to do |format|
      # format.html{ redirect_to image_page_path }
      format.js
    end

    # respond_to {|format| format.js}
  end

  def download_file 
    @uploaded = ProfilePictureUploader.new 
    @uploaded.retrieve_from_store!('something.jpg')
    image_path = File.join(Rails.root, "public", "images")
    send_file(File.join(image_path, @uploaded.url))
    # send_file Rails.root + @uploaded.url
  end

  # def image_page
  #   @uploader = ProfilePictureUploader.new 
  #   @uploader.retrieve_from_store!('something.jpg')
  # end 


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
