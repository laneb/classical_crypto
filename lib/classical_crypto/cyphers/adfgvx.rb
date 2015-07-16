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
		@key_type = AdfgvxKey
		
		@expect_even_length_cyphertext = true
		@plaintext_alphabet = "abcdefghijklmnopqrstuvwxyz0123456789"
		@cyphertext_alphabet = "ADFGVX"
		

		def fill_plain_text(ptext)
			substituted_text_length = 2*ptext.length
			
			number_of_letters_to_fill = ((key.period  -  (substituted_text_Length % key.period)) % key.period ) /2
			
			filled_ptext = ClassicalCrypto::Utils::Text.fill ptext, number_of_letters_to_fill

			filled_ptext
		end


		protected

		def _encrypt_(ptext)
			unless ClassicalCrypto::Utils::Math.divides? key.period, 2*ptext.length
				raise ArgumentError, "plaintext length does not fit period"
			end

			substituted_text = ClassicalCrypto::Utils::Text.substitute(ptext) {|ch| key.table.sub_char(ch)}

			ctext = ClassicalCrypto::Utils::Text.transpose(substituted_text, key.perm)

			ctext
		end


		def _decrypt_(ctext)
			unless ClassicalCrypto::Utils::Math.divides? key.period, ctext.length
				raise ArgumentError, "cyphertext length is not divisible by period"
			end

			inv_transposed_text = ClassicalCrypto::Utils::Text.inv_transpose(ctext, key.perm)

			ptext = ClassicalCrypto::Utils::Text.substitute(inv_transposed_text, 2) {|pair| key.table.backsub_pair(pair)}

			ptext
		end

	end
end
		




