require_relative "../util/cyphertools.rb"
require_relative "./cypher.rb"






class FourSquare < Cypher

	include Cypher::PureAlphabeticPlaintext

	require_relative "foursquare/foursquare_key.rb"

	set_key_type_to FourSquareKey

	protected

	def encode(ptext)			
		if ptext.length.even?
			filledPtext = String.new ptext
		else
			filledPtext = ptext + CypherTools::GARBAGE_CH
		end

		ctext = CypherTools::Text.substitute(filledPtext, 2) {|pair| key.table.sub_pair(pair)}

		ctext
	end

	def decode(ctext)
		raise ArgumentError, "cyphertext must be of even length" unless ctext.length.even?
		ptext = CypherTools::Text.substitute(ctext, 2) {|pair| key.table.backsub_pair(pair)}
	end


end