require_relative "./cypher.rb"
require_relative "../util/cyphertools.rb"





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~AdfgvxTable:
#~~Handles the encryption/decryption processes which would conceptually
#~~use a ADFGVX table, i.e. bialphabetic substitution. DOES NOT handle 
#~~the rectangular transposition that follows. Intended for use in the
#~~Adfgvx child class of Cypher.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


class AdfgvxTable < CypherTools::Tables::AlnumTable

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





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~Adfgvx
#
#~~Adfgvx is a subclass of Cypher which encrypts and decrypts messages according to
#~~the rules of the ADFGVX system. Adfgvx is a child class of Cypher and adds no 
#~~accessible methods.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


class Adfgvx < ClassicalCypher

	class AdfgvxKey < ClassicalCypher::Key
	
		attr_reader :table, :perm

		MaxPermLength = 16
		MinPermLength = 8

		def initialize(phrase, perm)
			unless phrase.is_a? String
				raise TypeError, "no implicit conversion of #{phrase.class} to String"
			end

			unless perm.is_a? Array
				raise TypeError, "no implicit conversion of #{perm.class} to Array"
			end

			unless perm.length.even?
				raise ArgumentError, "permutation Array must be of even length"
			end

			@table = AdfgvxTable.new(phrase)
			@perm = perm
			super(@table,  @perm)
		end


		def self.random
			permLen = 2*Random.rand( (MinPermLength/2)..(MaxPermLength/2) )

			phrase = CypherTools::Text.jumble_alnum		
			perm = CypherTools::Text.rand_perm permLen
			
			self.new(phrase, perm)
		end
	end

	set_key_type_to AdfgvxKey

	protected


	def encode(ptext)

		permLength = key.perm.length #must be even
		substitutedTextLength = 2*ptext.length
		numOfLettersToFill = ((permLength  -  (substitutedTextLength % permLength)) % permLength ) /2
		filledPtext = ptext + CypherTools::Text.garbage_alnum(numOfLettersToFill) 
		substitutedText = CypherTools::Text.substitute(filledPtext) {|ch| key.table.sub_char(ch)}

		ctext = CypherTools::Text.transpose(substitutedText, key.perm)

		ctext
	end


	def decode(ctext)
		unless ctext.length.even?
			raise ArgumentError, "cyphertext must be of even length"
		end

		if ctext.match /[^ADFGVX]/
			raise 	ArgumentError, "cyphertext may only include the characters ADFGVX"
		end


		invTransposedText = CypherTools::Text.inv_transpose(ctext, key.perm)

		ptext = CypherTools::Text.substitute(invTransposedText, 2) {|pair| key.table.backsub_pair(pair)}

		ptext
	end
end
	




