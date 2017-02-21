class FileuploadsController < ApplicationController
  def index
    jpgs = Dir.glob(Rails.root.join('public', '*.jpg'))
    @img_paths = jpgs.map { |png| '/' + File.basename(png) }
  end

  def create
    uploaded_file = fileupload_params[:file]
    output_path = Rails.root.join('public', uploaded_file.original_filename)

    File.open(output_path, 'w+b') do |fp|
      fp.write uploaded_file.read
    end

    redirect_to action: 'index'
  end

  def new
  end

  private
  def fileupload_params
    params.require(:fileupload).permit(:file)
  end
end
