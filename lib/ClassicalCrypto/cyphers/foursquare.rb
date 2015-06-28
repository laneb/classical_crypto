require_relative "../utils.rb"
require_relative "./cypher.rb"





module ClassicalCrypto::Cyphers

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: FourSquare
	#
	#~~Description: FourSquare is a subclass of Cypher which encrypts alphabetic text according
	#~~to the algorithm of the Four-square cypher: https://en.wikipedia.org/wiki/Four-square_cipher.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class FourSquare < Cypher

		include PureAlphabeticPlaintext
		include EvenLengthCyphertext

		require_relative "foursquare/foursquare_key.rb"

		set_key_type_to FourSquareKey

		protected

		def encode(ptext)			
			if ptext.length.even?
				filledPtext = String.new ptext
			else
				filledPtext = ptext + ClassicalCrypto::Utils::GARBAGE_CH
			end

			ctext = ClassicalCrypto::Utils::Text.substitute(filledPtext, 2) {|pair| key.table.sub_pair(pair)}

			ctext
		end

		def decode(ctext)
			ptext = ClassicalCrypto::Utils::Text.substitute(ctext, 2) {|pair| key.table.backsub_pair(pair)}

			ptext
		end


	end
end