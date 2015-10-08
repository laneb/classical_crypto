BIFID = ClassicalCrypto::Cyphers::Bifid

pTextsCtextsAndNewPtextsByKey = {
	["",6] => [
    %w[hithereworld GRDOSWEOLWRD hithereworld]
  ]
	

}
=begin
run_general_cypher_spec_for	BIFID,  
							pTextsCtextsAndNewPtextsByKey







RSpec.describe BIFID do
  describe "#encrypt" do
    context "with plaintext length which does not fit period" do
      it "should raise an ArgumentError" do
        expect {cypher.encrypt plaintext}.to raise_error ArgumentErrorknerear
      end
    end
  end

  describe "#decrypt" do
  	context "with odd length cyphertext" do
  	  cypher = BIFID.random
  	  cyphertext = "ABCDEFGHIJKLMNOPQRSTUVWXY"

  	  it "should raise an ArgumentError" do
        expect {cypher.decrypt cyphertext}.to raise_error ArgumentError, "cyphertext must be of even length"
      end
   	end
  end
end
=end