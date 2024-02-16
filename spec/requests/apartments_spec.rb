require 'rails_helper'

RSpec.describe "Apartments", type: :request do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  describe "GET /index" do
    it 'gets a list of apartments' do 
      apartment = user.apartments.create(
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg"
      )

      get '/apartments'

      apartment = JSON.parse(response.body)
      expect(apartment.first['street']).to eq("ABC Sesame Street")
      expect(apartment.first['unit']).to eq("20")
      expect(apartment.first['city']).to eq("Sesame")
      expect(apartment.first['state']).to eq("ISLE")
      expect(apartment.first['square_footage']).to eq(2000)
      expect(apartment.first['price']).to eq("1500")
      expect(apartment.first['bedrooms']).to eq(5)
      expect(apartment.first['bathrooms']).to eq(3)
      expect(apartment.first['pets']).to eq("puppets only")
      expect(apartment.first['image']).to eq("https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg")
      expect(response).to have_http_status(200)
    end
  end
end