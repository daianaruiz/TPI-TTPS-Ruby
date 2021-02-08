class User < ApplicationRecord
  after_create :create_global

  has_many :books, inverse_of: :user
  validates :fullname, presence: { message: 'El nombre es obligatorio' }, length: { maximum: 255 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def create_global
    new_global = Book.new user_id: self.id, title: "Global", is_global: true
    new_global.save
  end
end
