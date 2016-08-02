class PhotoUploader < CarrierWave::Uploader::Base
  aws_acl 'public-read'

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
