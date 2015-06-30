require_relative "../../utils.rb"

class ClassicalCrypto::Cyphers::Playfair

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: PlayfairTable
	#
	#~~Description: PlayfairTable is a Polybius square which also implements substitution
	#~~rules according to the algorithm of the Playfair cypher. 
	#
	#~~Constructor: PlayfairTable.new(phrase)
	#~~Initializes PlayfairTable as an AlphaTable using the String :phrase:.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class PlayfairTable < ClassicalCrypto::Utils::Tables::AlphaTable


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: sub_pair(pair) #=> String
		#
		#~~Description: sub_pair sub_pair returns a bialpabetic substitution of the String :pair: of
		#~~length 2 using the table according to the substitution algorithm of the Playfair cipher.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: backsub_pair(pair) #=> String
		#
		#~~Description: backsub_pair returns a bialpabetic substitution of the String :pair: of
		#~~length 2 using the table according to the inverse of the substitution algorithm 
		#~~of the Playfair cipher.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: shift_fw(coord) #=> Integer
		#
		#~~Description: Shift_fw returns Integer :coord: incremented by 1 (shifted right or 
		#~~down), or 0 if :coord: = 5 (coordinate is at the right or bottom edge of the table).
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def shift_fw(coord)
			(coord + 1) % 5
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: shift_back(coord) #=> Integer
		#
		#~~Description: shift_back returns Integer :coord: decremented by 1 (shifted left or 
		#~~up), or 0 if :coord: = 5 (coordinate is at the left or top edge of the table).
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def shift_back(coord)
			(coord + 5 - 1) % 5
		end

	end
end