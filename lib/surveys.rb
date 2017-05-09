class Survey < ActiveRecord::Base
  has_many(:questions)
  validates(:name, {:presence => true, :length => { :maximum => 200 }})
  before_save(:downcase_name)
  before_save(:capitalize)

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
end
