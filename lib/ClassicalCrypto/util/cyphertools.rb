require "prime.rb"


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~CypherTools:
#
#~~CypherTools is a collection of methods useful for processes related to encryption and
#~~decryption of text. These methods consist primarily of text manipulation.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



module CypherTools

	UTILDIR = "ClassicalCrypto/util"

	GARBAGE_CH = "q"
	ALPHABET_ARY = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
	ALPHABET_AND_DIGITS_ARY = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9]

	require_relative "CypherTools/text.rb"
	require_relative "CypherTools/math.rb"
	require_relative "CypherTools/tables.rb"

end










