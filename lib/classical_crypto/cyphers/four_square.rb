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

		

		require_relative "four_square/four_square_key.rb"
		@key_type = FourSquareKey

		@plaintext_alphabet = "abcdefghijklmnopqrstuvwxyz"
		@cyphertext_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		@expect_even_length_cyphertext = true

		protected

		def _encrypt_(ptext)			
			if ptext.length.odd?
				raise ArgumentError, "plaintext must be of even length"
			end

			ctext = ClassicalCrypto::Utils::Text.substitute(ptext, 2) {|pair| key.table.sub_pair(pair)}

			ctext
		end

		def _decrypt_(ctext)
			if ctext.length.odd?
				raise ArgumentError, "cyphertext must be of even length"
			end

			ptext = ClassicalCrypto::Utils::Text.substitute(ctext, 2) {|pair| key.table.backsub_pair(pair)}

			ptext
		end


	end
end