class Survey < ActiveRecord::Base
  has_many(:questions)
  validates(:name, {:presence => true, :length => { :maximum => 200 }})
  before_save(:downcase_name)

private

  define_method(:downcase_name) do
    self.name=(name().downcase())
  end

end
