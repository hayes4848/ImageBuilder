class ImageHandlersController < ApplicationController
  before_action :set_image_handler, only: [:show, :edit, :update, :destroy]
  # respond_to :js

  def index
    @image_handler = ImageHandler.new
    @image_handlers = ImageHandler.all
  end

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

  def process_image_one(params)
    filter = MiniMagick::Image.open("public/filter1.png")
    uploaded_image = MiniMagick::Image.open(params[:image_handler][:image_two].tempfile.path)
    image_manipulation(filter, uploaded_image)
  end

  def process_image_two(params)
    filter = MiniMagick::Image.open("public/filter2.png")
    uploaded_image = MiniMagick::Image.open(params[:image_handler][:image_two].tempfile.path)
    image_manipulation(filter, uploaded_image)
  end

  def image_manipulation(image_one, image_two)
    # image_one = MiniMagick::Image.open("public/filter1.png")
    # image_two = MiniMagick::Image.open(params[:image_handler][:image_two].tempfile.path)
    image_one.format "png"
    image_two.format "png"
    image_one.resize "500x500"
    image_two = resize_and_crop(image_two, 500, 500)


    result = image_two.composite(image_one) do |comp|
      comp.compose "Over"
      comp.geometry "+0+0"
    end
    result.format "png"
  end

  def process_images
    result_one = process_image_one(params)
    result_two = process_image_two(params)

    @uploader_one = ProfilePictureUploader.new
    @uploader_one.store!(result_one)
    @file_one_url = @uploader_one.url

    @uploader_two = ProfilePictureUploader.new
    @uploader_two.store!(result_two)
    @file_two_url = @uploader_two.url

    respond_to do |format|
      # format.html{ redirect_to image_page_path }
      format.js
    end

    # respond_to {|format| format.js}
  end

  private
    def set_image_handler
      @image_handler = ImageHandler.find(params[:id])
    end

    def image_handler_params
      params.fetch(:image_handler, {})
    end
end
