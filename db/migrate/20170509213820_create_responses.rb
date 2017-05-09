class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table(:responses) do |t|
      t.column(:content, :string)
      t.column(:question_id, :integer)

      t.timestamps()
    end
  end
end
