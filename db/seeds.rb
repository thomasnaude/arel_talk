questionnaire = [
  { question: 'Gender', possible_answers: %w(male female) },
  {
    question: 'Age',
    possible_answers: ['18-24 yo', '25-34 yo', '35-44 yo', '45-60 yo']
  },
  {
    question: 'Region',
    possible_answers: [
      'Paris Region', 'North-West', 'North-East', 'South-West', 'South-East'
    ]
  },
  { question: 'Occupation', possible_answers: %w(employed unemployed) }
]

questions = questionnaire.map.with_index do |args, i|
  question = Question.create!(label: args[:question], rank: i + 1)
  args[:possible_answers].each_with_index do |label, index|
    PossibleAnswer.create!(label: label, rank: index + 1, question: question)
  end
  question
end

1000.times do |i|
  respondent = Respondent.create!
  questions.each do |question|
    Answer.create!(
      possible_answer: question.possible_answers.sample,
      respondent: respondent
    )
  end
end
