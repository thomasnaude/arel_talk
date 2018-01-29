require_relative '../queries/respondents/filtered_count_per_possible_answer'

class Respondent < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :possible_answers, through: :answers
  has_many :questions, through: :possible_answers


  def self.filtered
    filters = [
      { possible_answers: ['18-24 yo', '25-34 yo'], question: 'Age' },
      { possible_answers: ['male'], question: 'Gender' }
    ]
    ::Respondents::FilteredPerPossibleAnswer.new(self, filters).call
  end
end
