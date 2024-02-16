class Apartment < ApplicationRecord
  belongs_to :user
  validates :street, :unit, :city, :state, :square_footage, :price, :bedrooms, :bathrooms, :pets, :image, :user_id, presence: true
end

# it 'should validate square_footage' do
#   apartment = user.apartments.create(
#     street: "ABC Sesame Street",
#     unit: "20",
#     city: "Sesame",
#     state: "ISLE",
#     square_footage: 2000,
#     price: 1500,
#     bedrooms: 5,
#     bathrooms: 3,
#     pets: "puppets only",
#     image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg"
#   )
#   expect(apartment.errors[:square_footage]).to include("can't be blank")
# end