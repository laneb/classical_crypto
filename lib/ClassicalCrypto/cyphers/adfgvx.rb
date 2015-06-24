require_relative "./cypher.rb"
require_relative "../util/cyphertools.rb"


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~Adfgvx
#
#~~Adfgvx is a subclass of Cypher which encrypts and decrypts messages according to
#~~the rules of the ADFGVX system. Adfgvx is a child class of Cypher and adds no 
#~~accessible methods.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


class Adfgvx < ClassicalCypher

	require_relative "adfgvx/adfgvx_key.rb"

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
	




