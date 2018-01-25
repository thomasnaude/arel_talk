class CreatePossibleAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :possible_answers do |t|
      t.string :label
      t.integer :rank
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
