require_relative "./general_cypher_spec.rb"

FOURSQUARE = ClassicalCrypto::Cyphers::FourSquare

pTextsCtextsAndNewPtextsByKey = {
	["", ""] => [
		%w[helloworld KCLLMYMTOA helloworld],
		%w[wellpaidscientistq ZBLLLEIDSCKDOSHTQT wellpaidscientistq]
	],

	["four", "square"] => [
		%w[helloworld GUHGIYIPLS helloworld],
		%w[wellpaidscientistq ZQHGHREAQUGALODPNP wellpaidscientistq]
	]
}

run_general_cypher_spec_for	FOURSQUARE, 
							pTextsCtextsAndNewPtextsByKey

RSpec.describe FOURSQUARE do
	
  describe "#encrypt" do
    context "when plaintext is of odd length" do
      cypher = FOURSQUARE.random
      plaintext = "abcdefghijklmnopqrstuvwxy" #length 25

      it "should raise an argument error" do
        expect {cypher.encrypt plaintext}.to raise_error ArgumentError, "plaintext must be of even length"
      end
    end
  end

  describe "#decrypt" do
    context "when cyphertext is of odd length" do
      cypher = FOURSQUARE.random
      cyphertext = "ABCDEFGHIJKLMNOPQRSTUVWXY" #length 25

      it "should raise an argument error" do
        expect {cypher.decrypt cyphertext}.to raise_error ArgumentError, "cyphertext must be of even length"
      end
    end
  end
	
end