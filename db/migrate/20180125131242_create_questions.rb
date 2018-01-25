class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :label
      t.integer :rank

      t.timestamps
    end
  end
end
