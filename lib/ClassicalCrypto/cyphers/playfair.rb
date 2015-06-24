require_relative "../util/cyphertools.rb"
require_relative "./cypher.rb"


class Playfair < Cypher	

	include PureAlphabeticPlaintext

	require_relative "playfair/playfair_key.rb"

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