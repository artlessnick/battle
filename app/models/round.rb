class Round < ApplicationRecord
  has_many :round_answers
  belongs_to :gamescore
end
