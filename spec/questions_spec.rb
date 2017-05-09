require("spec_helper")

describe(Question) do
  describe('#percentage') do
    it("returns the percentage of responses with the same answer") do
      test_question = Question.new({})
      patient1 = Patient.new({:name => "Mark Jones", :doctor_id => 1, :birthday => "2008-11-11"})
      patient2 = Patient.new({:name => "Mark Jones", :doctor_id => 1, :birthday => "2008-11-11"})
      expect(patient1==patient2).to(eq(true))
    end
  end
end
