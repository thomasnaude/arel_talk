class Question < ApplicationRecord
  has_many :possible_answers
  has_many :answers, through: :possible_answers
  has_many :respondents, through: :answers
end
