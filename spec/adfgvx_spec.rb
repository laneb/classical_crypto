require_relative "./general_cypher_spec.rb"

ADFGVX = ClassicalCrypto::Cyphers::Adfgvx

pTextsCtextsAndNewPtextsByKey = {
	[ "", [0,1,2,3,4,5,6,7,8,9] ] => [
		%w[hello\ world DGDVAFVFDFXXDDXXFAFG helloworld],
		%w[h3ll0'w0rld DGDVVVXFDFXXDDXXVAFG h3ll0w0rld]
	],

	[ "adfgvx", [9,8,7,6,5,4,3,2,1,0] ] => [
		%w[hello\ world VDFADDFFDDFGFVDFGXDG helloworld],
		%w[h3ll0'w0rld FDVADDFFDDFGXFVVGXDG h3ll0w0rld]
	],	

	[ "aaddffggvvxx", [9,8,7,6,5,4,3,2,1,0] ] => [
		%w[hello\ world VDFADDFFDDFGFVDFGXDG helloworld],
		%w[h3ll0'w0rld FDVADDFFDDFGXFVVGXDG h3ll0w0rld]
	]
}



run_general_cypher_spec_for	ADFGVX, 
							pTextsCtextsAndNewPtextsByKey



RSpec.describe ADFGVX, "#encrypt" do 
	key = ["", [0,3,1,2,5,4,6,7]]

	ptextsAndCtextPatterns = [
		%w[hello\ world DFDAGAVVGDFXXF.DF.DF.XX.],
		%w[h3ll0'w0rld DVDVGAXVGDFXXF.DV.DF.XX.]
	]

	cyph = ADFGVX.new *key

	context "with key #{key.inspect}" do
		ptextsAndCtextPatterns.each do |ptext, ctextPattern|
			it "should encrypt #{ptext} to match #{ctextPattern}" do
				expect(cyph.encrypt ptext).to match ctextPattern
			end
		end
	end
end

RSpec.describe ADFGVX, "#decrypt" do
	cyph = ADFGVX.random

	context "with cyphertext including characters besides ADFGVX" do
		it "should raise an ArgumentError" do
			expect {cyph.decrypt "AGXFGGDVVVXGKF"}.to raise_error ArgumentError
		end
	end

	context "with cyphertext of odd length" do
		it "should raise an ArgumentError" do
			expect {cyph.decrypt "GAVVFFDVXXXVG"}.to raise_error ArgumentError
		end
	end
end