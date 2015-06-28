class ClassicalCrypto::Cypher

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Module: EvenLengthCyphertext
	#
	#~~Description: EvenLengthCyphertext is a mixin which, when included, flags the 
	#~~decrypt method of Cypher to raise an exception if it receives as an argument a String
	#~~which is of odd length.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	module EvenLengthCyphertext

		EVEN_LENGTH_CTEXT = true

	end
end