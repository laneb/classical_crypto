require_relative "../util/cyphertools.rb"
require_relative "./cypher.rb"


class PlayfairTable < CypherTools::Tables::AlphaTable

	def sub_pair(pair)

		x1, y1, x2, y2 = *coord(pair[0]), *coord(pair[1])
		
		if x1 == x2
			entry(x1, shift_fw(y1)) + entry(x2, shift_fw(y2))
		elsif y1 == y2
			entry(shift_fw(x1), y1) + entry(shift_fw(x2), y2)
		else
			entry(x2, y1) + entry(x1, y2)
		end
	end


	def backsub_pair(pair)
		x1, y1, x2, y2 = *coord(pair[0].downcase), *coord(pair[1].downcase)
		
		if x1 == x2
			entry(x1, shift_back(y1)) + entry(x2, shift_back(y2))
		elsif y1 == y2
			entry(shift_back(x1), y1) + entry(shift_back(x2), y2)
		else
			entry(x2, y1) + entry(x1, y2)
		end
	end



	private

	def shift_fw(coord)
		(coord + 1) % 5
	end

	def shift_back(coord)
		(coord + 5 - 1) % 5
	end

end


class Playfair < ClassicalCypher

	class PlayfairKey < ClassicalCypher::Key

		attr_reader :table

		def initialize(phrase)
			unless phrase.is_a? String
				raise TypeError, "no implicit conversion of #{phrase.inspect}:#{phrase.class} to String given"
			end

			@table = PlayfairTable.new(phrase)
			
			super @table
		end

		def self.random
			self.new CypherTools::Text.jumble_alpha
		end
	end

	include PureAlphabeticPlaintext

	set_key_type_to PlayfairKey

	protected

	def encode(ptext)
		filledPtext = insert_filler(ptext)
		
		ctext = CypherTools::Text.substitute(filledPtext, 2) {|pair| key.table.sub_pair(pair)}
	
		ctext
	end


	def decode(ctext)
		ptext = CypherTools::Text.substitute(ctext, 2) {|pair| key.table.backsub_pair(pair)}

		ptext
	end


	private

	def insert_filler(ptext)
		idx = 0
		newPtext = String.new ptext


		until idx >= newPtext.length do 
			if newPtext[idx] == newPtext[idx+1] then
				newPtext.insert idx+1, CypherTools::GARBAGE_CH
			end
			idx += 2
		end


		unless newPtext.length % 2 == 0 
			newPtext << CypherTools::GARBAGE_CH
		end

		newPtext
	end
end