module ClassicalCrypto::Cyphers


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: Caesar
	#
	#~~Description: Caesar is a subclass of Cypher which encrypts alphanumeric text 
	#~~according to the algorithm of the Caesar cypher: https://en.wikipedia.org/wiki/Caesar_cipher
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class Caesar < Cypher



		require_relative "caesar/caesar_key.rb" 
		@key_type = CaesarKey

		@plaintext_alphabet = "abcdefghijklmnopqrstuvwxyz"
		@cyphertext_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

		protected

		def _encrypt_(ptext)
			ctext = shift ptext, key.shift_num

			ctext
		end

		def _decrypt_(ctext)
			ptext = shift ctext, 26-key.shift_num

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