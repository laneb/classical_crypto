module CypherTools
	module Tables

		class AlnumTable < LookUpTable

			WIDTH = 6


			#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			#~~initialize(str)
			#
			#~~initialize creates the array of characters @entries used to simulate the ADFGVX table.
			#~~@entries will always be initialized to include all 26 lower case alphabetical characters
			#~~and 10 digits.
			#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			
			def initialize(phrase = "")
				unless phrase.is_a? String
					raise TypeError, "no implicit coercion of #{phrase.class} to String"
				end

				characters = CypherTools::Text.unique CypherTools::Text.only_alnum phrase
				entries = characters.downcase.chars
				
				CypherTools::ALPHABET_AND_DIGITS_ARY.each {|ch| if !entries.include?(ch) then entries << ch end}
				
				super(entries, WIDTH)
			end	

		end
	end
end