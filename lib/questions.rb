class Question < ActiveRecord::Base
  belongs_to(:survey)
  validates(:content, {:presence => true, :length => { :maximum => 300 }})
  before_save(:downcase_content)

private

  define_method(:downcase_content) do
    self.content=(content().downcase())
  end

end
