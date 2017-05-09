class Question < ActiveRecord::Base
  belongs_to(:survey)
  has_many(:responses)
  validates(:content, {:presence => true, :length => { :maximum => 300 }})
  before_save(:downcase_content)

  define_method(:percentage) do |input|
    denominator = self.responses.length
    numerator = 0
    self.responses.each do |response|
      if response.content == input
        numerator += 1
      end
    end
    puts "num:#{numerator}"
    puts "den:#{denominator}"
    returned = numerator.to_f./(denominator).to_f.*(100)
    puts returned.round
    returned.round
  end

private

  define_method(:downcase_content) do
    self.content=(content().downcase())
  end

end
