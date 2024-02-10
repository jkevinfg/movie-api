require 'rails_helper'

describe 'DELETE /movies' do
  let!(:movie) { FactoryBot.create(:movie) }

  scenario 'valid movie attributes' do
    delete "/movies/#{movie.id}"
    expect(response.status).to eq(204)
  end
end
