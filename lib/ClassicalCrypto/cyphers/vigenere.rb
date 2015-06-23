require_relative "./cypher.rb"
require_relative "../util/cyphertools.rb"



class Vigenere < ClassicalCypher

	class VigenereKey < ClassicalCypher::Key

		RandLenMax = 16
		RandLenMin = 8

		attr_reader :shift

		def initialize(phrase)
			@shift = CypherTools.only_alpha(phrase).downcase
			super(@shift)
		end

		def self.random
			randLength = RandLenMin + rand(RandLenMax - RandLenMin)
			self.new(CypherTools.garbage_alpha(randLength))
		end
		
	end
	
	set_key_type_to VigenereKey
	
	include PureAlphabeticPlaintext

	

	protected


	def encode(ptext)
		
		klen = 	key.shift.length

		CypherTools.substitute(ptext, klen) do |textSeg|
			textChrs = textSeg.chars
			shiftChrs = @key.shift.chars
			
			newTextAry = textChrs.zip(shiftChrs).map do |txtCh, shiftCh|
				shiftNum = shiftCh.ord - 'a'.ord
				CypherTools.shift_alpha(txtCh, shiftNum)
			end 
			
			newTextAry.join
		end
	end


	def decode(ctext)
		klen = key.shift.length

		CypherTools.substitute(ctext, klen) do |textSeg|
			textChrs = textSeg.chars
			shiftChrs = @key.shift.chars

			newTextAry = textChrs.zip(shiftChrs).map do |txtCh, shiftCh| 
				shiftNum = shiftCh.ord - 'a'.ord
				CypherTools.shift_alpha(txtCh, -shiftNum)
			end

			newTextAry.join
		end
	end	

end