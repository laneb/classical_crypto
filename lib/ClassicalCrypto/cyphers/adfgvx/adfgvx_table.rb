require_relative "../../utils.rb"


class ClassicalCrypto::Cyphers::Adfgvx

	protected


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: AdfgvxTable
	#
	#~~Description: AdfgvxTable is a 6x6 Polybius square which also implements substitution
	#~~rules according to the algorithm of the ADFGVX cypher. 
	#
	#~~Constructor: AdfgvxTable.new(phrase)
	#~~Initializes AdfgvxTable as an AlnumTable using the String :phrase:.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class AdfgvxTable < ClassicalCrypto::Utils::Tables::AlnumTable

		ADFGVX = "ADFGVX"	
		
		
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~sub_char(str)  #=>  str
		#
		#~~sub_char returns the ciphertext character pair the corresponding to the argument, a 
		#~~plaintext character.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

		def sub_char(entry)
			col, row = coord(entry)
			ADFGVX[row] + ADFGVX[col]
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~backsub_pair(pair)  #=>  str
		#~~
		#~~backsub_pair returns the plaintext character corresponding to the pair of characters
		#~~in pair.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def backsub_pair(pair)
			col, row = ADFGVX.index(pair[0]), ADFGVX.index(pair[1])
			entry(row, col)
		end

	 		
	end
end