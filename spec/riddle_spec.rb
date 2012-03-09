require_relative "../lib/riddle"


describe Riddle do

  it "should give me the result" do
    subject.execute("1+1").should eq(2)
  end

  it "should capture the output" do
    subject.execute("puts 'oh hai'")
    subject.output.should eq("oh hai\n")
  end

  it "should not actually exception" do
    expect {
      subject.execute("raise StandardError.new('yo there')")
    }.to_not raise_error
  end

  it "should store off the exception to exception" do
    subject.execute("1/0")
    ex = subject.exception
    ex.should be_a(Exception)
  end

  it "shouldn't throw a syntax error" do
    expect {
      subject.execute("1+{")
    }.to_not raise_error
  end

	it "shouldn't exception on a load error" do
		expect {
      subject.execute("require 'nopers'; puts 'nopers'")
    }.to_not raise_error
	end

end
