class Gamescore < ApplicationRecord
  has_many :rounds
  belongs_to :user
end
