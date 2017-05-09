class AddAnswerColumnToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column(:questions, :answers, :string)
  end
end
