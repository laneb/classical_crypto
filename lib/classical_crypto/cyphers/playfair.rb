require_relative "../utils.rb"
require_relative "./cypher.rb"

module ClassicalCrypto::Cyphers
	class Playfair < Cypher	

		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Class: Playfair
		#
		#~~Description: Playfair is a subclass of Cypher which encrypts alphanumeric text 
		#~~according to the algorithm of the Playfair cypher: https://en.wikipedia.org/wiki/Playfair_cipher
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		require_relative "playfair/playfair_key.rb"

		@key_type = PlayfairKey

		@plaintext_alphabet = "abcdefghijklmnopqrstuvwxyz"
		@cyphertext_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

		protected

		def _encrypt_(ptext)
			filledPtext = insert_filler(ptext)
			
			ctext = ClassicalCrypto::Utils::Text.substitute(filledPtext, 2) {|pair| key.table.sub_pair(pair)}
		
			ctext
		end


		def _decrypt_(ctext)
			ptext = ClassicalCrypto::Utils::Text.substitute(ctext, 2) {|pair| key.table.backsub_pair(pair)}

			ptext
		end


		private

		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: insert_filler(ptext) #=> String
		#
		#~~Description: insert_filler returns the contents of ptext with a garbage character
		#~~inserted to split up consecutive identical letters and such that the returned 
		#~~String is of even length.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def insert_filler(ptext)
			idx = 0
			newPtext = String.new ptext


			until idx >= newPtext.length do 
				if newPtext[idx] == newPtext[idx+1] then
					newPtext.insert idx+1, ClassicalCrypto::Utils::GARBAGE_CH
				end
				idx += 2
			end


			unless newPtext.length % 2 == 0 
				newPtext << ClassicalCrypto::Utils::GARBAGE_CH
			end

			newPtext
		end
	end
end