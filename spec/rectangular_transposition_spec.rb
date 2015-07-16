require_relative "./general_cypher_spec.rb"

RECTANGULAR_TRANSPOSITION = ClassicalCrypto::Cyphers::RectangularTransposition

pTextsCtextsAndNewPtextsByKey = {
	[ [3,4,2,1,0] ] => [
		%w[helloworld ODLLLRHWEO helloworld]
	]
}

run_general_cypher_spec_for	RECTANGULAR_TRANSPOSITION,  
							pTextsCtextsAndNewPtextsByKey

RSpec.describe RECTANGULAR_TRANSPOSITION do
  
  describe "#encrypt" do
    
    context "when the plaintext length is not divisible by the key length" do
       
       cypher = RECTANGULAR_TRANSPOSITION.new [0,1,2,3,4,5,6,7,8,9] #permutation of length 10
       plaintext = "0123456789012345678901234" #plaintext of length 25, not divisible by 10

       it "should raise an ArgumentError" do
         expect {cypher.encrypt plaintext}.to raise_error ArgumentError, "plaintext length is not divisible by period"
       end
    
    end

  end


  describe "decrypt" do
    
    context "when the cyphertext length is not divisible by the key length" do
       
       cypher = RECTANGULAR_TRANSPOSITION.new [0,1,2,3,4,5,6,7,8,9] #permutation of length 10
       cyphertext = "0123456789012345678901234" #plaintext of length 25, not divisible by 10

       it "should raise an ArgumentError" do
         expect {cypher.decrypt cyphertext}.to raise_error ArgumentError, "cyphertext length is not divisible by period"
       end
    
    end

  end
  

end