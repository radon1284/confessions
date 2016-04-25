class Book < ActiveRecord::Base
  has_one :product, as: :purchasable
  has_many :chapters, dependent: :destroy

  validates_presence_of :slug, :title

  mount_uploader :content_pdf, BookContentPDFUploader
  mount_uploader :content_epub, BookContentEPUBUploader
  mount_uploader :content_mobi, BookContentMOBIUploader
end
