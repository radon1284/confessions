class Book < ActiveRecord::Base
  has_one :product, as: :purchasable
  has_many :chapters, dependent: :destroy

  validates :slug, :title, presence: true

  mount_uploader :content_pdf, BookContentPDFUploader
  mount_uploader :content_epub, BookContentEPUBUploader
  mount_uploader :content_mobi, BookContentMOBIUploader
  mount_uploader :content_pdf_preview, BookContentPDFPreviewUploader

  def partial_name
    slug.tr("-", "_")
  end
end
