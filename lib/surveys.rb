class Survey < ActiveRecord::Base
  has_many(:questions, dependent: :destroy)
  validates(:name, {:presence => true, :length => { :maximum => 200 }})
  before_save(:downcase_name)
  before_save(:capitalize)
  # before_destroy(:delete_questions)

private

  define_method(:downcase_name) do
    self.name=(name().downcase())
  end

  define_method(:capitalize) do
    words = self.name.split(" ")
    words.each do |word|
      word.capitalize!()
    end
    self.name=(words.join(" "))
  end

  # define_method(:delete_questions) do
  #   answers.each do |answer|
  #     answer.destroy
  #   end
  # end
  
end
