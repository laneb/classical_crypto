module ClassicalCrypto

	
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Module: Cyphers
	#
	#~~Description: Cyphers is a namespace for all cypher classes.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	module Cyphers


		require_relative "cyphers/adfgvx.rb"
		require_relative "cyphers/affine.rb"
		require_relative "cyphers/bifid.rb"
		require_relative "cyphers/caesar.rb"
		require_relative "cyphers/four_square.rb"
		require_relative "cyphers/playfair.rb"
		require_relative "cyphers/rectangular_transposition.rb"
		require_relative "cyphers/vigenere.rb"


	end


end