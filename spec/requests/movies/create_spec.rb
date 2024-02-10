require 'rails_helper'
# rspec spec/requests/movies/create_spec.rb

describe 'POST /movies' do
  let!(:title) { Faker::Movie.title }
  let!(:quote) { Faker::Movie.quote }

  scenario 'validate movie creation' do
    post '/movies', params: {
      movie: {
        title: title,
        quote: quote
      }
    }

    expect(response.status).to eq(201)
    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:title]).to eq(title)
    expect(json[:quote]).to eq(quote)

    expect(Movie.count).to eq(1)
    expect(Movie.last.title).to eq(title)
  end

  scenario 'valid movie attributes' do
    post '/movies', params: {
      movie: {
        title: '',
        quote: quote
      }
    }

    expect(response.status).to eq(422)
    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:title]).to eq(["can't be blank"])
    expect(Movie.count).to eq(0)
  end
end
