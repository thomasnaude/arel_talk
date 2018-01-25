class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.references :possible_answer, foreign_key: true
      t.references :respondent, foreign_key: true

      t.timestamps
    end
  end
end
