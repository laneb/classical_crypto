module ClassicalCrypto

	
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Module: Cyphers
	#
	#~~Description: Cyphers is a namespace for all cypher classes.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



	module Cyphers

		files_to_include = %w[
			adfgvx.rb
			affine.rb
			caesar.rb
			four_square.rb
			playfair.rb
			rectangular_transposition.rb
			vigenere.rb
		]
		
		files_to_include.each {|file_name| require_relative "cyphers/#{file_name}"}

	end


end