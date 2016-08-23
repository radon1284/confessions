class BookContentPDFPreviewUploader < CarrierWave::Uploader::Base
  aws_acl 'public-read'
  aws_authenticated_url_expiration 1.minute

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def download_url
    url(response_content_disposition: "attachment")
  end

  def extension_white_list
    ["pdf"]
  end
end
