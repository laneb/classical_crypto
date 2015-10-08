CAESAR = ClassicalCrypto::Cyphers::Caesar

pTextsCtextsAndNewPtextsByKey = {
	
	["a"] => [
		%w[helloworld HELLOWORLD helloworld]
	],

	["r"] => [
		%w[helloworld YVCCFNFICU helloworld]
	],

	["z"] => [
		%w[helloworld GDKKNVNQKC helloworld]
	]

}

run_general_cypher_spec_for	CAESAR,  
							pTextsCtextsAndNewPtextsByKey




RSpec.describe CAESAR, "#new" do 

	context "key string isn't of length 1" do
		it "should raise an ArgumentError" do
			expect {CAESAR.new ""}.to raise_error ArgumentError
			expect {CAESAR.new "bd"}.to raise_error ArgumentError
		end
	end


	context "key string isn't alphabetic" do
		it "should raise a ArgumentError" do
			expect {CAESAR.new "6"}.to raise_error ArgumentError
		end
	end
	
end