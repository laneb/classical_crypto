require_relative "./cypher.rb"
require_relative "../utils.rb"


module ClassicalCrypto::Cyphers


	class Vigenere < Cypher


		require_relative "vigenere/vigenere_key.rb"
		set_key_type_to VigenereKey
		

		include PureAlphabeticPlaintext

		

		protected


		def encode(ptext)
			
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


		def decode(ctext)
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