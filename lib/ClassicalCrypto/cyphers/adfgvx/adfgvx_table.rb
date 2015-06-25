require_relative "../../utils.rb"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~AdfgvxTable:
#~~Handles the encryption/decryption processes which would conceptually
#~~use a ADFGVX table, i.e. bialphabetic substitution. DOES NOT handle 
#~~the rectangular transposition that follows. Intended for use in the
#~~Adfgvx child class of Cypher.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class ClassicalCrypto::Cyphers::Adfgvx

	protected

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