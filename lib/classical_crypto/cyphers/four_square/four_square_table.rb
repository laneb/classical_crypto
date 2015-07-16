require_relative "../../utils.rb"

class ClassicalCrypto::Cyphers::FourSquare

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: FourSquareTable
	#
	#~~Description: FourSquareTable is a collection of AlphaTables (Polybius squares)
	#~~which implements substitution methods according to the algorithm of the Four-square
	#~~cypher. 
	#
	#~~Constructor: FourSquareTable.new(phrase1, phrase2)
	#~~Initializes 2 AlphaTables with :phrase1: and :phrase2: respectively.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class FourSquareTable

		ALPHA = ClassicalCrypto::Utils::Tables::AlphaTable.new

		def initialize(phrase1, phrase2)
			@code_table1 = ClassicalCrypto::Utils::Tables::AlphaTable.new(phrase1)
			@code_table2 = ClassicalCrypto::Utils::Tables::AlphaTable.new(phrase2)
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: sub_pair(pair) #=> String
		#
		#~~Description: sub_pair returns a bialpabetic substitution of the String :pair: of
		#~~length 2 using the table according to the substitution algorithm of the Four-square cipher.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def sub_pair(pair)
			ch1, ch2 = pair[0], pair[1]
			x1, y1, x2, y2 = *ALPHA.coord(ch1), *ALPHA.coord(ch2)
			@code_table1.entry_at_indices(x2, y1) + @code_table2.entry_at_indices(x1, y2)
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: backsub_pair(pair) #=> String
		#
		#~~Description: backsub_pair returns a bialpabetic substitution of the String :pair: of
		#~~length 2 using the table according to the inverse of the substitution algorithm 
		#~~of the Four-square cipher.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def backsub_pair(pair)
			ch1, ch2 = pair[0].downcase, pair[1].downcase

			x1, y1, x2, y2 = *@code_table1.coord(ch1), *@code_table2.coord(ch2)
			
			ALPHA.entry_at_indices(x2, y1) + ALPHA.entry_at_indices(x1, y2)
		end

	end
end