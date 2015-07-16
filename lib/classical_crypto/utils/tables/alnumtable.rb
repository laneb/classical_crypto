module ClassicalCrypto::Utils::Tables


	require_relative "lookuptable.rb"


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: AlphaTable
	#
	#~~Description: AlphaTable is a 5x5 LookUpTable whose 26 entries include A-Z09 (and only A-Z0-9).
	#
	#~~Constructor: AlphaTable.new(phrase = "")
	#~~Table will be initialized by writing the contents of :phrase: from left to right, top to
	#~~bottom of the table, ignoring duplicate entries. Then the remaining alphanumeric characters 
	#~~will be written in in the same manner.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class AlnumTable < LookUpTable


		WIDTH = 6
		
		
		def initialize(phrase = "")

			unless phrase.is_a? String
				raise TypeError, "no implicit coercion of #{phrase.class} to String"
			end

			characters = ClassicalCrypto::Utils::Text.unique ClassicalCrypto::Utils::Text.only_alnum phrase
			entries = characters.downcase.chars
			
			ClassicalCrypto::Utils::ALPHABET_AND_DIGITS_ARY.each {|ch| if !entries.include?(ch) then entries << ch end}
			
			super(entries, WIDTH)
		end	


	end


end