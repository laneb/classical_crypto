require_relative "../util/cyphertools.rb"
require_relative "./cypher.rb"




class FourSquareTable

	include PureAlphabeticPlaintext

	ALPHA = CypherTools::AlphaTable.new

	def initialize(phrase1, phrase2)
		@code_table1 = CypherTools::AlphaTable.new(phrase1)
		@code_table2 = CypherTools::AlphaTable.new(phrase2)
	end


	def sub_pair(pair)
		ch1, ch2 = pair[0], pair[1]
		x1, y1, x2, y2 = *ALPHA.coord(ch1), *ALPHA.coord(ch2)
		@code_table1.entry(x2, y1) + @code_table2.entry(x1, y2)
	end


	def backsub_pair(pair)
		ch1, ch2 = pair[0].downcase, pair[1].downcase

		x1, y1, x2, y2 = *@code_table1.coord(ch1), *@code_table2.coord(ch2)
		ALPHA.entry(x2, y1) + ALPHA.entry(x1, y2)
	end

end

class FourSquare < ClassicalCypher

	include PureAlphabeticPlaintext

	class FourSquareKey < ClassicalCypher::Key

		attr_reader :table

		def initialize(phrase1, phrase2)
			[phrase1, phrase2].each do |phrase|
				unless phrase.is_a? String
					raise TypeError, "no implicit conversion of #{phrase.class} to String" 
				end
			end

			@table = FourSquareTable.new(phrase1, phrase2)
			super(@table)
		end	


		def self.random
			self.new CypherTools.jumble_alpha, CypherTools.jumble_alpha
		end

	end

	set_key_type_to FourSquareKey

	protected

	def encode(ptext)			
		if ptext.length.even?
			filledPtext = String.new ptext
		else
			filledPtext = ptext + CypherTools::GARBAGE_CH
		end

		ctext = CypherTools.substitute(filledPtext, 2) {|pair| key.table.sub_pair(pair)}

		ctext
	end

	def decode(ctext)
		raise ArgumentError, "cyphertext must be of even length" unless ctext.length.even?
		ptext = CypherTools.substitute(ctext, 2) {|pair| key.table.backsub_pair(pair)}
	end


end