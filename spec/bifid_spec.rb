require_relative "./general_cypher_spec.rb"
=begin
BIFID = ClassicalCrypto::Cyphers::Bifid

pTextsCtextsAndNewPtextsByKey = {
	
	

}

run_general_cypher_spec_for	BIFID,  
							pTextsCtextsAndNewPtextsByKey







RSpec.describe BIFID do
  describe "#decrypt" do
  	context "with odd length cyphertext" do
  	  cypher = BIFID.random
  	  cyphertext = "ABCDEFGHIJKLMNOPQRSTUVWXY"

  	  it "should raise an ArgumentError" do
        expect {cypher.decrypt cyphertext}.to raise_error ArgumentError "cyphertext must be of even length"
      end
   	end
  end
end
=end