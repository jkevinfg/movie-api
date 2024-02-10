FactoryBot.define do
  factory :movie, class: "Movie" do
    title { Faker::Movie.title }
    quote { Faker::Movie.quote }
  end
end
