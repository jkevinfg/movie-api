class Movie < ApplicationRecord
  validates :title, presence: true, allow_blank: false
  validates :quote, presence: true, allow_blank: false
end
