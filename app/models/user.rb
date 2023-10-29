class User < ApplicationRecord
    has_many :reservations, foreign_key: 'guest_id', class_name: 'Reservation'
    has_many :listenings, foreign_key: 'admin_id', class_name: 'Listing'

     validates :email,
     presence: true,
     uniqueness: true,
     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "email adress please" }
     validates :phone_number,
     format: { with: /\A\+?\d{1,4}(-\d{1,4})*\s?\d{1,15}( x\d{1,10})?\z/,
     message: "please enter a valid phone number" }
     validates :description,
     length: { maximum: 500 }
end
