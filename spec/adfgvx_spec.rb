ADFGVX = ClassicalCrypto::Cyphers::Adfgvx

pTextsCtextsAndNewPtextsByKey = {
	[ "", [0,1,2,3,4,5,6,7,8,9] ] => [
		%w[helloworld DGDVAFVFDFXXDDXXFAFG helloworld],
		%w[h3ll0w0rld DGDVVVXFDFXXDDXXVAFG h3ll0w0rld]
	],

	[ "adfgvx", [9,8,7,6,5,4,3,2,1,0] ] => [
		%w[helloworld VDFADDFFDDFGFVDFGXDG helloworld],
		%w[h3ll0w0rld FDVADDFFDDFGXFVVGXDG h3ll0w0rld]
	],	

	[ "aaddffggvvxx", [9,8,7,6,5,4,3,2,1,0] ] => [
		%w[helloworld VDFADDFFDDFGFVDFGXDG helloworld],
		%w[h3ll0w0rld FDVADDFFDDFGXFVVGXDG h3ll0w0rld]
	]
}



run_general_cypher_spec_for	ADFGVX, 
							pTextsCtextsAndNewPtextsByKey



RSpec.describe ADFGVX do

	describe "#new" do
		context "permutation array does not include all digits less than its length" do

			permutation = [2,4,1,9,7,0,3,8,6,10]

			it "should raise an ArgumentError" do
				expect {ADFGVX.new "", permutation}.to raise_error ArgumentError
			end
		end
	end

	describe "#encrypt" do 
		context "when plaintext length does not fit the key period" do

			cyphers = [	ADFGVX.new("", [0,1,2,3]), #period 4
					  	ADFGVX.new("flajea912", [2,0,1,3,4,5,7,6]), #period 8
					  	ADFGVX.new("an441axla121lalen", [13,2,0,8,9,6,7,3,1,4,15,14,12,11,10,5]) #period 16
			]


			incongruous_ptexts = [	"012345678901234567890", #length 42 after substitution, not divisible by 4
									"abcdefghijklmnopqrstuvwxyz", #length 52 after substitution, not divisible by 8
									"abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz01234567890" # length 146 after substitution, not divisible by 16
			]

			cyphers.zip(incongruous_ptexts).each do |cypher, incongruous_plaintext|
				it "should raise an ArgumentError" do
					expect {cypher.encrypt incongruous_plaintext}.to raise_error ArgumentError, "plaintext length does not fit period"
				end
			end
		end
	end

	describe "#decrypt" do
		cypher = ADFGVX.random

		context "with cyphertext including characters besides ADFGVX" do
			it "should raise an ArgumentError" do
				expect {cypher.decrypt "AGXFGGDVVVXGKF"}.to raise_error ArgumentError
			end
		end

		
		context "with cyphertext of odd length" do
			it "should raise an ArgumentError" do
				expect {cypher.decrypt "GAVVFFDVXXXVG"}.to raise_error ArgumentError
			end
		end


		context "with cyphertext not divisible by key period" do
			
			cyphers = 	[	ADFGVX.new("", [0,1,2,3]), #period 4
						  	ADFGVX.new("flajea912", [2,0,1,3,4,5,7,6]), #period 8
						  	ADFGVX.new("an441axla121lalen", [13,2,0,8,9,6,7,3,1,4,15,14,12,11,10,5]) #period 16
			]

			incongruous_ctexts = [ 	"ADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVX", #length 42, not divisible by 4
									"ADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVX", #length 78, not divisible by 8
									"ADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVXADFGVX" #length 108, not divisible by 108					
			]

			cyphers.zip(incongruous_ctexts).each do |cypher, incongruous_cyphertext|
				it "should raise an ArgumentError" do
					expect {cypher.decrypt incongruous_cyphertext}.to raise_error ArgumentError, "cyphertext length is not divisible by period"
				end
			end
		end
	end
end