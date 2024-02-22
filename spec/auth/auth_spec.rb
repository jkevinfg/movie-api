# rspec spec/auth/auth_spec.rb
require "rails_helper"

describe 'Authentication', type: :request do
  let!(:user) { FactoryBot.create(:user) }

  scenario 'login successful' do
    post "/login", params: {
      user: {
        email: user.email,
        password: user.password
      }
    }
    expect(response.status).to eq(200)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:status][:message]).to eq("Logged in successfully.")
  end

  scenario 'login successful' do
    post "/login", params: {
      user: {
        email: user.email,
        password: ''
      }
    }
    expect(response.status).to eq(401)
    expect(response.body).to eq("Invalid Email or password.")
  end

  let!(:email) { Faker::Internet.email }

  scenario 'successful registration' do
    post "/signup", params: {
      user: {
        email: email,
        password: Faker::Internet.password(min_length: 6)
      }
    }
    expect(response.status).to eq(200)
    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:status][:message]).to eq("Signed up successfully.")
  end

  scenario 'password is too short' do
    post "/signup", params: {
      user: {
        email: email,
        password: Faker::Internet.password(min_length: 2, max_length: 5)
      }
    }

    expect(response.status).to eq(422)
  end
end
