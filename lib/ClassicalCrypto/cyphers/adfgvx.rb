require_relative "./cypher.rb"
require_relative "../utils.rb"




module ClassicalCrypto::Cyphers

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: Adfgvx
	#
	#~~Description: Adfgvx is a subclass of Cypher which encrypts alphanumeric text 
	#~~according to the algorithm of the ADFGVX cypher: https://en.wikipedia.org/wiki/ADFGVX_cipher 
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class Adfgvx < Cypher

		require_relative "adfgvx/adfgvx_key.rb"

		set_key_type_to AdfgvxKey

		protected


		def encode(ptext)

			permLength = key.perm.length #must be even
			substitutedTextLength = 2*ptext.length
			numOfLettersToFill = ((permLength  -  (substitutedTextLength % permLength)) % permLength ) /2
			filledPtext = ClassicalCrypto::Utils::Text.fill ptext, numOfLettersToFill
			substitutedText = ClassicalCrypto::Utils::Text.substitute(filledPtext) {|ch| key.table.sub_char(ch)}

			ctext = ClassicalCrypto::Utils::Text.transpose(substitutedText, key.perm)

			ctext
		end


		def decode(ctext)
			unless ctext.length.even?
				raise ArgumentError, "cyphertext must be of even length"
			end

			if ctext.match /[^ADFGVX]/
				raise 	ArgumentError, "cyphertext may only include the characters ADFGVX"
			end


			invTransposedText = ClassicalCrypto::Utils::Text.inv_transpose(ctext, key.perm)

			ptext = ClassicalCrypto::Utils::Text.substitute(invTransposedText, 2) {|pair| key.table.backsub_pair(pair)}

			ptext
		end
	end
end
		




