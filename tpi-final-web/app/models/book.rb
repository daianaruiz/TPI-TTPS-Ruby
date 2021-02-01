class Book < ApplicationRecord
    validates :title, presence: true, length: { maximum: 255 }, uniqueness: { scope: :user }
    has_many :notes, inverse_of: :book
    validates_associated :notes
end
