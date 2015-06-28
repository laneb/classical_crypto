class ClassicalCrypto::Cyphers::Cypher

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Module: PureAlphabeticPlaintext
	#
	#~~Description: PureAlphabeticPlaintext is a mixin which, when included, flags the 
	#~~encrypt method of Cypher to raise an exception if it receives as an argument a String
	#~~which includes digits.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	module PureAlphabeticPlaintext

		PURE_ALPHA_PTEXT = true

	end
end