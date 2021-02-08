class Note < ApplicationRecord
  belongs_to :book, optional: true, inverse_of: :notes
  validates :title, presence: { message: 'El título es obligatorio' }, length: { maximum: 255 }
  validates :title, uniqueness: { scope: :book, message: 'El título ya existe' }
  validates :content, presence: { message: 'El contenido de la nota es obligatorio' }
end
