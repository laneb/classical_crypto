require_relative "../utils.rb"
require_relative "./cypher.rb"

module ClassicalCrypto::Cyphers

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: Affine
	#
	#~~Description: Affine is a subclass of Cypher which encrypts alphanumeric text 
	#~~according to the algorithm of the affine cypher: https://en.wikipedia.org/wiki/Affine_cipher
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class Affine < Cypher


		require_relative "affine/affine_key.rb"
		@key_type = AffineKey

		@plaintext_alphabet = "abcdefghijklmnopqrstuvwxyz"
		@cyphertext_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

		protected

		def _encrypt_(ptext)

			ctext = ClassicalCrypto::Utils::Text.substitute(ptext) {|ch| sub_char(ch)}

			ctext
		end	

		def _decrypt_(ctext)

			ptext = ClassicalCrypto::Utils::Text.substitute(ctext) {|ch| backsub_char(ch)}

			ptext
		end

		private


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: sub_char(ch) #=> String
		#
		#~~Description: sub_char substitutes character ch with a new character according
		#~~to the affine substitution function.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def sub_char(ch)
			(((key.coeff * (ch.ord - 97) + key.const) % 26) + 97).chr
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: backsub_char(ch) #=> String
		#
		#~~Description: backsub_char substitutes character ch with a new character according
		#~~to the inverse of the affine substitution function.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def backsub_char(ch)
			(((key.inv_coeff * ((ch.ord - 65) - key.const)) % 26) + 65).chr
		end

	end
end