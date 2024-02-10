require 'rails_helper'
# bundle exec rspec
describe 'PUT /movies' do
  let!(:movie) { FactoryBot.create(:movie) }

  scenario 'valid movie attributes' do
    put "/movies/#{movie.id}", params: {
      movie: {
        title: movie.title,
        quote: movie.quote
      }
    }
    expect(response.status).to eq(200)

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:title]).to eq(movie.title)
    expect(json[:quote]).to eq(movie.quote)

    expect(movie.reload.title).to eq(movie.title)
    expect(movie.reload.quote).to eq(movie.quote)
  end

  scenario 'invalid movie attributes' do
    put "/movies/#{movie.id}", params: {
      movie: {
        title: "",
        quote:  movie.quote
      }
    }

    expect(response.status).to eq(422)

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:title]).to eq(["can't be blank"])

    expect(movie.reload.title).to eq(movie.title)
    expect(movie.reload.quote).to eq(movie.quote)
  end
end
