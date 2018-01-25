class Respondent < ApplicationRecord
  has_many :answers
  has_many :possible_answers, through: :answers
  has_many :questions, through: :possible_answers
end
