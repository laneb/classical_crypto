require_relative "../../utils.rb"
require_relative "../cypher.rb"

class ClassicalCrypto::Cyphers::FourSquare

	require_relative "four_square_table.rb"


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: FourSquareKey
	#
	#~~Description: FourSquareKey is a subclass of Key which stores key data for the
	#~~FourSquare cypher. 
	#
	#~~Constructor: FourSquareKey.new(phrase1, phrase2)
	#~~Initializes a FourSquareTable with :phrase1: and :phrase2:
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class FourSquareKey < Key

		attr_reader :table

		def initialize(phrase1, phrase2)
			[phrase1, phrase2].each do |phrase|
				unless phrase.is_a? String
					raise TypeError, "no implicit conversion of #{phrase.class} to String" 
				end
			end

			@table = FourSquareTable.new(phrase1, phrase2)
			super phrase1, phrase2
		end	


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.random #=> FourSquareKey
		#
		#~~Description: returns a FourSquareKey generated with 2 randomly ordered alphabets
		#~~as phrases.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.random
			self.new ClassicalCrypto::Utils::Text.jumble_alpha, ClassicalCrypto::Utils::Text.jumble_alpha
		end

	end
end