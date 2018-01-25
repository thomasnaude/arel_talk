class Answer < ApplicationRecord
  belongs_to :possible_answer
  belongs_to :respondent
end
