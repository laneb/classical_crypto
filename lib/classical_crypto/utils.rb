module ClassicalCrypto


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Module: Utils
	#
	#~~Description: Utils is a namespace including the Math, Text, and Tables modules and
	#~~several constants.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	module Utils


		GARBAGE_CH = "q"
		ALPHABET_ARY = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
		ALPHABET_AND_DIGITS_ARY = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9]

		require_relative "utils/math.rb"
		require_relative "utils/text.rb"
		require_relative "utils/tables.rb"


	end


end