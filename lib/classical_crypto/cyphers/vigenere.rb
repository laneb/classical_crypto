require_relative "./cypher.rb"
require_relative "../utils.rb"


module ClassicalCrypto::Cyphers


	class Vigenere < Cypher


		require_relative "vigenere/vigenere_key.rb"
		@key_type = VigenereKey
		
		@plaintext_alphabet = "abcdefghijklmnopqrstuvwxyz"
		@cyphertext_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	

		protected


		def _encrypt_(ptext)
			
			klen = 	key.shift.length

			ClassicalCrypto::Utils::Text.substitute(ptext, klen) do |textSeg|
				textChrs = textSeg.chars
				shiftChrs = @key.shift.chars
				
				newTextAry = textChrs.zip(shiftChrs).map do |txtCh, shiftCh|
					shiftNum = shiftCh.ord - 'a'.ord
					ClassicalCrypto::Utils::Text.shift_alpha(txtCh, shiftNum)
				end 
				
				newTextAry.join
			end
		end


		def _decrypt_(ctext)
			klen = key.shift.length

			ClassicalCrypto::Utils::Text.substitute(ctext, klen) do |textSeg|
				textChrs = textSeg.chars
				shiftChrs = @key.shift.chars

				newTextAry = textChrs.zip(shiftChrs).map do |txtCh, shiftCh| 
					shiftNum = shiftCh.ord - 'a'.ord
					ClassicalCrypto::Utils::Text.shift_alpha(txtCh, -shiftNum)
				end

				newTextAry.join
			end
		end	


	end


end