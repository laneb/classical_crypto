module ClassicalCrypto::Cyphers


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: Caesar
	#
	#~~Description: Caesar is a subclass of Cypher which encrypts alphanumeric text 
	#~~according to the rectangular substitution algorithm: 
	#~~https://en.wikipedia.org/wiki/Transposition_cipher#Columnar_transposition
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class RectangularTransposition < Cypher


		require_relative "rectangular_transposition/rectangular_transposition_key.rb" 
		@key_type = RectangularTranspositionKey

		@plaintext_alphabet = "abcdefghijklmnopqrstuvwxyz0123456789"
		@cyphertext_alphabet = "ABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"

		protected


		def fill_ptext(ptext)

		end

		def _encrypt_(ptext)
			unless ClassicalCrypto::Utils::Math.divides? key.period, ptext.length
				raise ArgumentError, "plaintext length is not divisible by period"
			end

			ctext = ClassicalCrypto::Utils::Text.transpose ptext, key.perm

			ctext
		end

		def _decrypt_(ctext)
			unless ClassicalCrypto::Utils::Math.divides? key.period, ctext.length
				raise ArgumentError, "cyphertext length is not divisible by period"
			end

			ptext = ClassicalCrypto::Utils::Text.inv_transpose ctext, key.perm

			ptext
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: shift(text, shift_num)  #=>  String
		#
		#~~Description: shift_num returns a String composed of the characters of :text: shifted by a
		#~~magnitude of :shift_num:, wrapping cyclically at the beginning and end of the alphabet
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

		def shift(text, shift_num)
			ClassicalCrypto::Utils::Text.substitute(text) do |ch| 
				ClassicalCrypto::Utils::Text.shift_alpha ch, shift_num
			end
		end

	end


end