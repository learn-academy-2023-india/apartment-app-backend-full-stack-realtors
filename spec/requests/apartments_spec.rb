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

  it 'creates a new apartment' do 
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params

    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    apartment = Apartment.first 
    expect(apartment['street']).to eq("ABC Sesame Street")
    expect(apartment['unit']).to eq("20")
    expect(apartment['city']).to eq("Sesame")
    expect(apartment['state']).to eq("ISLE")
    expect(apartment['square_footage']).to eq(2000)
    expect(apartment['price']).to eq("1500")
    expect(apartment['bedrooms']).to eq(5)
    expect(apartment['bathrooms']).to eq(3)
    expect(apartment['pets']).to eq("puppets only")
    expect(apartment['image']).to eq("https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg")
    expect(apartment['user_id']).to eq(user.id)
  end

  it "doesn't create an apartment without a street" do
    apartment_params = {
      apartment: {
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params

    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['street']).to include "can't be blank"
  end

  it "doesn't create an apartment without a unit" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['unit']).to include "can't be blank"
  end

  it "doesn't create an apartment without a city" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['city']).to include "can't be blank"
  end

  it "doesn't create an apartment without a state" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['state']).to include "can't be blank"
  end

  it "doesn't create an apartment without a square footage" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['square_footage']).to include "can't be blank"
  end

  it "doesn't create an apartment without a price" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['price']).to include "can't be blank"
  end

  it "doesn't create an apartment without a bedrooms" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['bedrooms']).to include "can't be blank"
  end

  it "doesn't create an apartment without a bathrooms" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['bathrooms']).to include "can't be blank"
  end

  it "doesn't create an apartment without a pets" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['pets']).to include "can't be blank"
  end

  it "doesn't create an apartment without a image" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        user_id: user.id
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['image']).to include "can't be blank"
  end

  it "doesn't create an apartment without a user id" do
    apartment_params = {
      apartment: {
        street: "ABC Sesame Street",
        unit: "20",
        city: "Sesame",
        state: "ISLE",
        square_footage: 2000,
        price: 1500,
        bedrooms: 5,
        bathrooms: 3,
        pets: "puppets only",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/00/Sesame_Street_buildings_%28193090534%29.jpg",
      }
    }
    post '/apartments', params: apartment_params
    
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['user_id']).to include "can't be blank"
  end
end