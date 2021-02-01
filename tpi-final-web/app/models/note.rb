class Note < ApplicationRecord
  belongs_to :book, optional: true, inverse_of: :notes

  validates :title, presence: true, length: { maximum: 255 }
  validates :title, uniqueness: { scope: :book }
  validates :content, presence: true
end
