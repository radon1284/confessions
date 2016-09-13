class WatermarkedBook < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates(
    :order,
    :book,
    :content_pdf,
    :content_epub,
    :content_mobi,
    presence: true
  )

  delegate :title, to: :book

  mount_uploader :content_pdf, BookContentPDFUploader
  mount_uploader :content_epub, BookContentEPUBUploader
  mount_uploader :content_mobi, BookContentMOBIUploader
end
