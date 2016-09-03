module Admin
  class PhotosController < Admin::BaseController
    def index
      photos = Photo.order(created_at: :desc).page(params[:page]).per(50)
      render(
        locals: {
          photos: photos
        }
      )
    end

    def create
      photo = Photo.new
      photo.file = photo_params[:file]
      photo.save!
      redirect_to admin_photos_path
    end

    def new
      photo = Photo.new
      render(
        locals: {
          photo: photo
        }
      )
    end

    def destroy
      Photo.find(params[:id]).destroy!
      redirect_to admin_photos_path
    end

    private

    def photo_params
      params.require(:photo).permit(:file)
    end
  end
end
