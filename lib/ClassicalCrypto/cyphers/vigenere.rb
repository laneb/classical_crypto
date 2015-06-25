require_relative "./cypher.rb"
require_relative "../util/cyphertools.rb"



class Vigenere < Cypher

	require_relative "vigenere/vigenere_key.rb"
	
	set_key_type_to VigenereKey
	
	include Cypher::PureAlphabeticPlaintext

	

	protected


	def encode(ptext)
		
		klen = 	key.shift.length

		CypherTools::Text.substitute(ptext, klen) do |textSeg|
			textChrs = textSeg.chars
			shiftChrs = @key.shift.chars
			
			newTextAry = textChrs.zip(shiftChrs).map do |txtCh, shiftCh|
				shiftNum = shiftCh.ord - 'a'.ord
				CypherTools::Text.shift_alpha(txtCh, shiftNum)
			end 
			
			newTextAry.join
		end
	end


	def decode(ctext)
		klen = key.shift.length

		CypherTools::Text.substitute(ctext, klen) do |textSeg|
			textChrs = textSeg.chars
			shiftChrs = @key.shift.chars

			newTextAry = textChrs.zip(shiftChrs).map do |txtCh, shiftCh| 
				shiftNum = shiftCh.ord - 'a'.ord
				CypherTools::Text.shift_alpha(txtCh, -shiftNum)
			end

			newTextAry.join
		end
	end	

end