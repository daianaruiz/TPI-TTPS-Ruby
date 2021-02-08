class Book < ApplicationRecord
    belongs_to :user, optional: true, inverse_of: :books
    validates :title, presence: { message: 'El título es obligatorio' }, length: { maximum: 255 }, uniqueness: { scope: :user, message: 'El título ya existe' }
    has_many :notes, inverse_of: :book
    validates_associated :notes
end
